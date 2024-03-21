#include <iostream>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <thread>
#include <unordered_map>

const int PORT_IN = 8815; // Port for incoming connections
const int PORT_OUT = 8814; // Port for outgoing connections

std::unordered_map<std::string, int> active_connections; // Store active connections by client IP address

// Function to handle communication with client
void handle_client(int client_socket) {
    // TODO: Implement communication with client
}

int main() {
    // Create socket for incoming connections
    int server_socket_in = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket_in == -1) {
        std::cerr << "Error creating socket for incoming connections" << std::endl;
        return 1;
    }

    // Prepare the sockaddr_in structure
    sockaddr_in server_address_in;
    server_address_in.sin_family = AF_INET;
    server_address_in.sin_addr.s_addr = INADDR_ANY;
    server_address_in.sin_port = htons(PORT_IN);

    // Bind
    if (bind(server_socket_in, (struct sockaddr *)&server_address_in, sizeof(server_address_in)) == -1) {
        std::cerr << "Bind failed for incoming connections" << std::endl;
        close(server_socket_in);
        return 1;
    }

    // Listen
    if (listen(server_socket_in, 3) == -1) {
        std::cerr << "Listen failed for incoming connections" << std::endl;
        close(server_socket_in);
        return 1;
    }

    std::cout << "Waiting for incoming connections..." << std::endl;

    // Accept incoming connections and handle them in separate threads
    while (true) {
        sockaddr_in client_address;
        socklen_t client_addrlen = sizeof(client_address);
        int client_socket = accept(server_socket_in, (struct sockaddr *)&client_address, &client_addrlen);
        if (client_socket == -1) {
            std::cerr << "Accept failed for incoming connections" << std::endl;
            close(server_socket_in);
            return 1;
        }

        // Check if there is an active connection for this client
        std::string client_ip = inet_ntoa(client_address.sin_addr);
        if (active_connections.find(client_ip) != active_connections.end()) {
            // Use existing connection
            int server_socket_out = active_connections[client_ip];
            std::cout << "Using existing connection for client: " << client_ip << std::endl;
            std::thread(handle_client, client_socket).detach(); // Start thread to handle communication
            close(client_socket); // Close the new connection
        } else {
            // Create new connection
            std::cout << "Creating new connection for client: " << client_ip << std::endl;
            int server_socket_out = socket(AF_INET, SOCK_STREAM, 0);
            if (server_socket_out == -1) {
                std::cerr << "Error creating socket for outgoing connections" << std::endl;
                close(client_socket);
                close(server_socket_in);
                return 1;
            }

            // Prepare the sockaddr_in structure
            sockaddr_in server_address_out;
            server_address_out.sin_family = AF_INET;
            server_address_out.sin_addr.s_addr = inet_addr("127.0.0.1"); // IP of local machine
            server_address_out.sin_port = htons(PORT_OUT);

            // Connect to outgoing server
            if (connect(server_socket_out, (struct sockaddr *)&server_address_out, sizeof(server_address_out)) == -1) {
                std::cerr << "Connect failed for outgoing connections" << std::endl;
                close(client_socket);
                close(server_socket_out);
                close(server_socket_in);
                return 1;
            }

            // Store active connection
            active_connections[client_ip] = server_socket_out;

            // Start thread to handle communication
            std::thread(handle_client, client_socket).detach();
        }
    }

    return 0;
}
