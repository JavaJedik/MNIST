#include <iostream>
#include <vector>
#include <boost/asio.hpp>

class LoadBalancer {
public:
    LoadBalancer(boost::asio::io_context& io_context, const std::vector<std::string>& server_addresses, unsigned short port)
        : io_context_(io_context), acceptor_(io_context, boost::asio::ip::tcp::endpoint(boost::asio::ip::tcp::v4(), port)), servers_(server_addresses), next_server_index_(0) {
        start_accept();
    }

private:
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
        boost::asio::ip::tcp::resolver resolver(io_context_);
        auto endpoint_iterator = resolver.resolve(boost::asio::ip::tcp::resolver::query(servers_[next_server_index_], "http"));
        next_server_index_ = (next_server_index_ + 1) % servers_.size();
        
        boost::asio::async_connect(*server_socket, endpoint_iterator, [this, client_socket, server_socket](const boost::system::error_code& error, const boost::asio::ip::tcp::endpoint& /*endpoint*/) {
            if (!error) {
                std::cout << "Connected to server: " << server_socket->remote_endpoint() << std::endl;
                start_proxy(client_socket, server_socket);
            }
        });
    }

    void start_proxy(std::shared_ptr<boost::asio::ip::tcp::socket> client_socket, std::shared_ptr<boost::asio::ip::tcp::socket> server_socket) {
        auto buffer = std::make_shared<std::array<char, 1024>>();
        client_socket->async_read_some(boost::asio::buffer(*buffer), [this, client_socket, server_socket, buffer](const boost::system::error_code& error, std::size_t bytes_transferred) {
            if (!error) {
                std::cout << "Received from client: " << bytes_transferred << " bytes" << std::endl;
                boost::asio::async_write(*server_socket, boost::asio::buffer(*buffer, bytes_transferred), [this, client_socket, server_socket, buffer](const boost::system::error_code& error, std::size_t) {
                    if (!error) {
                        start_proxy(client_socket, server_socket);
                    }
                });
            }
        });
    }

private:
    boost::asio::io_context& io_context_;
    boost::asio::ip::tcp::acceptor acceptor_;
    std::vector<std::string> servers_;
    std::size_t next_server_index_;
};

int main() {
    boost::asio::io_context io_context;
    std::vector<std::string> server_addresses = {"127.0.0.1", "127.0.0.1"}; // Example server addresses
    unsigned short port = 8815; // Port

    LoadBalancer load_balancer(io_context, server_addresses, port);

    io_context.run();

    return 0;
}

