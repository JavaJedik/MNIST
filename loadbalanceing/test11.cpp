#include <iostream>
#include <thread>
#include <chrono>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

const int PORT_IN = 8815; // Port for incoming connections
const int PORT_OUT = 8814; // Port for outgoing connections

void handle_client(int client_socket) {
    char buffer[1024];
    while (true) {
        int bytes_received = recv(client_socket, buffer, sizeof(buffer), MSG_DONTWAIT);
        if (bytes_received == -1) {
            if (errno == EAGAIN || errno == EWOULDBLOCK) {
                // No data available, sleep for a while
                std::this_thread::sleep_for(std::chrono::milliseconds(100));
                continue;
            } else {
                std::cerr << "Error receiving data from client" << std::endl;
                break;
            }
        } else if (bytes_received == 0) {
            std::cout << "Client disconnected" << std::endl;
            break;
        }

        // Handle received data, e.g., echo it back
        int bytes_sent = send(client_socket, buffer, bytes_received, 0);
        if (bytes_sent != bytes_received) {
            std::cerr << "Error sending data to client" << std::endl;
            break;
        }
    }

    close(client_socket);
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

    std::cout << "Server listening on port " << PORT_IN << std::endl;

    // Accept incoming connection
    while (true) {
        sockaddr_in client_address;
        socklen_t client_addrlen = sizeof(client_address);
        int client_socket = accept(server_socket_in, (struct sockaddr *)&client_address, &client_addrlen);
        if (client_socket == -1) {
            std::cerr << "Accept failed for incoming connections" << std::endl;
            continue;
        }

        std::cout << "Incoming connection accepted" << std::endl;

        // Create a new thread to handle the client connection
        std::thread(handle_client, client_socket).detach();
    }

    close(server_socket_in);

    return 0;
}
