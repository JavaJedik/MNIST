#include <iostream>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

const int CLIENT_PORT = 8815; // Port for incoming client connections
const int SERVER_PORT = 8814; // Port for outgoing server connections

int main() {
    // Create socket for incoming client connections
    int client_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (client_socket == -1) {
        std::cerr << "Error creating socket for client connections" << std::endl;
        return 1;
    }

    // Prepare the sockaddr_in structure
    sockaddr_in client_address;
    client_address.sin_family = AF_INET;
    client_address.sin_addr.s_addr = INADDR_ANY;
    client_address.sin_port = htons(CLIENT_PORT);

    // Bind
    if (bind(client_socket, (struct sockaddr *)&client_address, sizeof(client_address)) == -1) {
        std::cerr << "Bind failed for client connections" << std::endl;
        close(client_socket);
        return 1;
    }

    // Listen
    if (listen(client_socket, 3) == -1) {
        std::cerr << "Listen failed for client connections" << std::endl;
        close(client_socket);
        return 1;
    }

    std::cout << "Server listening for client connections on port " << CLIENT_PORT << std::endl;

    // Create socket for outgoing server connection
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        std::cerr << "Error creating socket for server connection" << std::endl;
        close(client_socket);
        return 1;
    }

    // Prepare the sockaddr_in structure
    sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = inet_addr("127.0.0.1"); // IP of local machine
    server_address.sin_port = htons(SERVER_PORT);

    // Connect to server
    if (connect(server_socket, (struct sockaddr *)&server_address, sizeof(server_address)) == -1) {
        std::cerr << "Connect failed to server" << std::endl;
        close(client_socket);
        close(server_socket);
        return 1;
    }

    std::cout << "Connected to server on port " << SERVER_PORT << std::endl;

    // Accept incoming client connections and forward data
    while (true) {
        sockaddr_in client_addr;
        socklen_t client_addrlen = sizeof(client_addr);
        int client_connection = accept(client_socket, (struct sockaddr *)&client_addr, &client_addrlen);
        if (client_connection == -1) {
            std::cerr << "Accept failed for client connections" << std::endl;
            continue;
        }

        std::cout << "Client connected" << std::endl;

        char buffer[1024];
        int bytes_received;

        while ((bytes_received = recv(client_connection, buffer, sizeof(buffer), 0)) > 0) {
            int bytes_sent = send(server_socket, buffer, bytes_received, 0);
            if (bytes_sent != bytes_received) {
                std::cerr << "Error sending data to server" << std::endl;
                break;
            }
        }

        close(client_connection);
    }

    close(client_socket);
    close(server_socket);

    return 0;
}
