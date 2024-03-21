#include <iostream>
#include <boost/asio.hpp>

class LoadBalancer {
public:
    LoadBalancer(boost::asio::io_service& io_service, short port, const std::string& server_address, short server_port)
        : acceptor_(io_service, boost::asio::ip::tcp::endpoint(boost::asio::ip::tcp::v4(), port)),
          io_service(io_service),
          server_address_(server_address), server_port_(server_port) {
        start_accept();
    }

private:
    void start_accept() {
        auto new_socket = std::make_shared<boost::asio::ip::tcp::socket>(io_service);
        acceptor_.async_accept(*new_socket, [this, new_socket](const boost::system::error_code& error) {
            if (!error) {
                std::cout << "Accepted connection from: " << new_socket->remote_endpoint() << std::endl;
                start_server_connection(new_socket);
            } else {
                std::cerr << "Accept error: " << error.message() << std::endl;
            }
            start_accept();
        });
    }

    void start_server_connection(std::shared_ptr<boost::asio::ip::tcp::socket> client_socket) {
        auto server_socket = std::make_shared<boost::asio::ip::tcp::socket>(io_service);
        server_socket->async_connect(
            boost::asio::ip::tcp::endpoint(boost::asio::ip::address::from_string(server_address_), server_port_),
            [this, client_socket, server_socket](const boost::system::error_code& error) {
                if (!error) {
                    std::cout << "Connected to server: " << server_socket->remote_endpoint() << std::endl;
                    start_proxy(client_socket, server_socket);
                } else {
                    std::cerr << "Server connection error: " << error.message() << std::endl;
                }
            });
    }

    void start_proxy(std::shared_ptr<boost::asio::ip::tcp::socket> client_socket,
                     std::shared_ptr<boost::asio::ip::tcp::socket> server_socket) {
        auto buffer = std::make_shared<std::array<char, 8192>>();
        client_socket->async_read_some(
            boost::asio::buffer(*buffer),
            [this, client_socket, server_socket, buffer](const boost::system::error_code& error, std::size_t bytes_transferred) {
                if (!error) {
                    boost::asio::async_write(
                        *server_socket, boost::asio::buffer(*buffer, bytes_transferred),
                        [this, client_socket, server_socket, buffer](const boost::system::error_code& error, std::size_t) {
                            if (!error) {
                                start_proxy(client_socket, server_socket);
                            } else {
                                std::cerr << "Write error to server: " << error.message() << std::endl;
                            }
                        });
                } else {
                    std::cerr << "Read error from client: " << error.message() << std::endl;
                }
            });
    }

    boost::asio::ip::tcp::acceptor acceptor_;
    boost::asio::io_service& io_service;
    std::string server_address_;
    short server_port_;
};

int main() {
    try {
        boost::asio::io_service io_service;
        LoadBalancer load_balancer(io_service, 8815, "127.0.0.1", 8814);
        io_service.run();
    } catch (std::exception& e) {
        std::cerr << "Exception: " << e.what() << std::endl;
    }
    return 0;
}
