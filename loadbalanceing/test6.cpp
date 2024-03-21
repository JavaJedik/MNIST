#include <iostream>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <thread>

const int PORT_IN = 8815; // Port for incoming connections to the load balancer
const int PORT_OUT = 8814; // Port for outgoing connections from the load balancer to the server

void forward_message(int client_socket) {
    // Create socket for outgoing connections to the server
    int server_socket_out = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket_out == -1) {
        std::cerr << "Error creating socket for outgoing connections" << std::endl;
        return;
    }

    // Prepare the sockaddr_in structure for the server
    sockaddr_in server_address_out;
    server_address_out.sin_family = AF_INET;
    server_address_out.sin_addr.s_addr = inet_addr("127.0.0.1"); // IP address of the server
    server_address_out.sin_port = htons(PORT_OUT);

    // Connect to the server
    if (connect(server_socket_out, (struct sockaddr *)&server_address_out, sizeof(server_address_out)) == -1) {
        std::cerr << "Connect failed for outgoing connections" << std::endl;
        close(server_socket_out);
        return;
    }

    // Forward messages between client and server
    char buffer[1024];
    while (true) {
        int bytes_read = recv(client_socket, buffer, sizeof(buffer), 0);
        if (bytes_read <= 0) {
            std::cerr << "Error reading from client socket" << std::endl;
            break;
        }

        int bytes_sent = send(server_socket_out, buffer, bytes_read, 0);
        if (bytes_sent != bytes_read) {
            std::cerr << "Error sending to server socket" << std::endl;
            break;
        }

        bytes_read = recv(server_socket_out, buffer, sizeof(buffer), 0);
        if (bytes_read <= 0) {
            std::cerr << "Error reading from server socket" << std::endl;
            break;
        }

        bytes_sent = send(client_socket, buffer, bytes_read, 0);
        if (bytes_sent != bytes_read) {
            std::cerr << "Error sending to client socket" << std::endl;
            break;
        }
    }

    // Close socket for outgoing connections
    close(server_socket_out);
}

int main() {
    // Create socket for incoming connections to the load balancer
    int server_socket_in = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket_in == -1) {
        std::cerr << "Error creating socket for incoming connections" << std::endl;
        return 1;
    }

    // Prepare the sockaddr_in structure for the load balancer
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

    std::cout << "Load balancer started, waiting for incoming connections..." << std::endl;

    // Main loop: Accept incoming connections and forward messages
    while (true) {
        sockaddr_in client_address;
        socklen_t client_addrlen = sizeof(client_address);
        int client_socket = accept(server_socket_in, (struct sockaddr *)&client_address, &client_addrlen);
        if (client_socket == -1) {
            std::cerr << "Accept failed for incoming connections" << std::endl;
            continue;
        }

        std::cout << "Incoming connection accepted from " << inet_ntoa(client_address.sin_addr) << std::endl;

        // Start a new thread to handle the client
        std::thread(forward_message, client_socket).detach();
    }

    // Close socket for incoming connections
    close(server_socket_in);

    return 0;
}
