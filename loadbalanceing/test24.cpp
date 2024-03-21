#include <iostream>
#include <vector>
#include <boost/asio.hpp>
#include <boost/bind/bind.hpp>

using namespace boost::asio;
using namespace boost::asio::ip;
using namespace boost::system;
using namespace std;

class LoadBalancer {
public:
    LoadBalancer(io_service& io_service, const vector<string>& server_addresses, short port)
            : io_service_(io_service),
              acceptor_(io_service, tcp::endpoint(tcp::v4(), port)),
              server_addresses_(server_addresses),
              next_server_index_(0) {
        start_accept();
    }

private:
    void start_accept() {
        auto new_socket = make_shared<tcp::socket>(io_service_);

        acceptor_.async_accept(*new_socket, [this, new_socket](const error_code& error) {
            if (!error) {
                handle_accept(new_socket);
            }
            start_accept();
        });
    }

    void handle_accept(shared_ptr<tcp::socket> client_socket) {
        cout << "Accepted connection from: " << client_socket->remote_endpoint() << endl;

        auto server_socket = make_shared<tcp::socket>(io_service_);
        auto server_endpoint = tcp::endpoint(address::from_string(get_next_server()), 80);

        server_socket->async_connect(server_endpoint, [this, client_socket, server_socket](const error_code& error) {
            if (!error) {
                start_proxy(client_socket, server_socket);
            } else {
                cerr << "Error connecting to server: " << error.message() << endl;
                client_socket->close();
            }
        });
    }

    void start_proxy(shared_ptr<tcp::socket> client_socket, shared_ptr<tcp::socket> server_socket) {
        auto self = shared_from_this();

        client_socket->async_read_some(buffer(client_buffer_),
            [this, self, client_socket, server_socket](const error_code& error, size_t bytes_transferred) {
                if (!error) {
                    async_write(*server_socket, buffer(client_buffer_, bytes_transferred),
                        [this, self, client_socket, server_socket](const error_code& error, size_t /*bytes_transferred*/) {
                            if (!error) {
                                start_proxy(client_socket, server_socket);
                            } else {
                                cerr << "Error writing to server: " << error.message() << endl;
                                client_socket->close();
                                server_socket->close();
                            }
                        }
                    );
                } else {
                    cerr << "Error reading from client: " << error.message() << endl;
                    client_socket->close();
                    server_socket->close();
                }
            }
        );
    }

    string get_next_server() {
        if (next_server_index_ >= server_addresses_.size()) {
            next_server_index_ = 0;
        }
        return server_addresses_[next_server_index_++];
    }

    io_service& io_service_;
    tcp::acceptor acceptor_;
    vector<string> server_addresses_;
    size_t next_server_index_;
    array<char, 8192> client_buffer_;
};

int main() {
    try {
        io_service io_service;
        vector<string> server_addresses = {"127.0.0.1"}; // Example server addresses
        short port = 8815; // Example port

        LoadBalancer load_balancer(io_service, server_addresses, port);
        io_service.run();
    } catch (const exception& e) {
        cerr << "Exception: " << e.what() << endl;
    }

    return 0;
}
