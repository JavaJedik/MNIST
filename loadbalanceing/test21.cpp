#include <iostream>
#include <memory>
#include <boost/asio.hpp>

class LoadBalancer : public std::enable_shared_from_this<LoadBalancer> {
public:
    LoadBalancer(boost::asio::io_context& io_context, short port, const std::string& server_address, short server_port)
        : io_context_(io_context),
          acceptor_(io_context, boost::asio::ip::tcp::endpoint(boost::asio::ip::tcp::v4(), port)),
          server_endpoint_(boost::asio::ip::address::from_string(server_address), server_port) {
        start_accept();
    }

    void start_accept() {
        auto new_socket = std::make_shared<boost::asio::ip::tcp::socket>(io_context_);
        acceptor_.async_accept(*new_socket, [this, new_socket](const boost::system::error_code& error) {
            if (!error) {
                std::cout << "Accepted connection from: " << new_socket->remote_endpoint() << std::endl;
                start_server_connection(new_socket);
            }
            start_accept();
        });
    }

    void start_server_connection(std::shared_ptr<boost::asio::ip::tcp::socket> client_socket) {
        auto server_socket = std::make_shared<boost::asio::ip::tcp::socket>(io_context_);
        server_socket->async_connect(server_endpoint_, [this, client_socket, server_socket](const boost::system::error_code& error) {
            if (!error) {
                std::cout << "Connected to server: " << server_socket->remote_endpoint() << std::endl;
                start_proxy(client_socket, server_socket);
            }
        });
    }

    void start_proxy(std::shared_ptr<boost::asio::ip::tcp::socket> client_socket,
                     std::shared_ptr<boost::asio::ip::tcp::socket> server_socket) {
        auto self = shared_from_this(); // Referencia az objektumhoz

        // Itt folytathatod a proxy logikájának implementálását...
    }

private:
    boost::asio::io_context& io_context_;
    boost::asio::ip::tcp::acceptor acceptor_;
    boost::asio::ip::tcp::endpoint server_endpoint_;
};

int main() {
    try {
        boost::asio::io_context io_context;
        short port = 8080;
        std::string server_address = "127.0.0.1";
        short server_port = 9090;

        auto load_balancer = std::make_shared<LoadBalancer>(io_context, port, server_address, server_port);

        io_context.run();
    } catch (std::exception& e) {
        std::cerr << "Exception: " << e.what() << std::endl;
    }

    return 0;
}
