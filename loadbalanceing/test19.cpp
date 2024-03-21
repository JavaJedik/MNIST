#include <iostream>
#include <vector>
#include <boost/asio.hpp>

using boost::asio::ip::tcp;

class LoadBalancer {
public:
    LoadBalancer(boost::asio::io_context& io_context, std::vector<std::string> server_ips, unsigned short server_port)
        : acceptor_(io_context, tcp::endpoint(tcp::v4(), 8815)),
          server_ips_(std::move(server_ips)),
          server_port_(server_port),
          next_server_index_(0)
    {
        start_accept();
    }

private:
    void start_accept()
    {
        tcp::socket client_socket(acceptor_.get_executor());
        acceptor_.async_accept(client_socket, [this, &client_socket](const boost::system::error_code& error) {
            if (!error) {
                std::cout << "Client connected." << std::endl;
                handle_request(std::move(client_socket));
            } else {
                std::cerr << "Accept error: " << error.message() << std::endl;
            }
            start_accept();
        });
    }

    void handle_request(tcp::socket client_socket)
    {
        std::string server_ip = server_ips_[next_server_index_];
        next_server_index_ = (next_server_index_ + 1) % server_ips_.size();

        boost::asio::io_context io_context;
        tcp::resolver resolver(io_context);
        tcp::resolver::results_type endpoints = resolver.resolve(server_ip, std::to_string(server_port_));
        tcp::socket server_socket(io_context);
        boost::asio::connect(server_socket, endpoints);

        std::cout << "Forwarding request to server: " << server_ip << std::endl;

        // Forwarding data between client and server
        boost::asio::streambuf request_buffer;
        boost::asio::async_read_until(client_socket, request_buffer, "\r\n\r\n",
                                      [&client_socket, &server_socket, &request_buffer](const boost::system::error_code& error, size_t bytes_transferred) {
            if (!error) {
                boost::asio::async_write(server_socket, request_buffer,
                                          [&client_socket, &server_socket](const boost::system::error_code& error, size_t bytes_transferred) {
                    if (!error) {
                        // Continue reading from client and writing to server
                        handle_client_read_write(client_socket, server_socket);
                    } else {
                        std::cerr << "Write to server error: " << error.message() << std::endl;
                        client_socket.close();
                        server_socket.close();
                    }
                });
            } else {
                std::cerr << "Read from client error: " << error.message() << std::endl;
                client_socket.close();
                server_socket.close();
            }
        });
    }

    void handle_client_read_write(tcp::socket& client_socket, tcp::socket& server_socket)
    {
        auto read_buffer = std::make_shared<boost::asio::streambuf>();
        boost::asio::async_read_until(client_socket, *read_buffer, "\r\n\r\n",
                                      [&client_socket, &server_socket, read_buffer](const boost::system::error_code& error, size_t bytes_transferred) {
            if (!error) {
                boost::asio::async_write(server_socket, *read_buffer,
                                          [&client_socket, &server_socket, read_buffer](const boost::system::error_code& error, size_t bytes_transferred) {
                    if (!error) {
                        // Continue reading from client and writing to server
                        handle_client_read_write(client_socket, server_socket);
                    } else {
                        std::cerr << "Write to server error: " << error.message() << std::endl;
                        client_socket.close();
                        server_socket.close();
                    }
                });
            } else {
                std::cerr << "Read from client error: " << error.message() << std::endl;
                client_socket.close();
                server_socket.close();
            }
        });
    }

    tcp::acceptor acceptor_;
    std::vector<std::string> server_ips_;
    unsigned short server_port_;
    std::size_t next_server_index_;
};

int main()
{
    try {
        boost::asio::io_context io_context;
        std::vector<std::string> server_ips = {"127.0.0.1", "127.0.0.1", "127.0.0.1"}; // List of server IPs
        unsigned short server_port = 8814; // Port for the servers
        LoadBalancer load_balancer(io_context, std::move(server_ips), server_port);
        io_context.run();
    } catch (const std::exception& e) {
        std::cerr << "Exception: " << e.what() << std::endl;
    }

    return 0;
}
