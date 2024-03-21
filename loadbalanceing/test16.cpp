#include <iostream>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

const int PORT_IN = 8815; // Port for incoming connections
const int PORT_OUT = 8814; // Port for outgoing connections

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

    // Accept incoming connection
    sockaddr_in client_address;
    socklen_t client_addrlen = sizeof(client_address);
    int client_socket = accept(server_socket_in, (struct sockaddr *)&client_address, &client_addrlen);
    if (client_socket == -1) {
        std::cerr << "Accept failed for incoming connections" << std::endl;
        close(server_socket_in);
        return 1;
    }

    std::cout << "Incoming connection accepted" << std::endl;

    // Create socket for outgoing connections
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

    std::cout << "Outgoing connection established" << std::endl;

    // Main loop: Forward data between sockets
    while (true) {
        char buffer[4096];
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

    // Close sockets
    close(client_socket);
    close(server_socket_out);
    close(server_socket_in);

    return 0;
}
