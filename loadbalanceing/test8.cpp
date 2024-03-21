#include <iostream>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <thread>
#include <unordered_map>

const int PORT_IN = 8815; // Port for incoming connections
const int PORT_OUT = 8814; // Port for outgoing connections

std::unordered_map<int, int> client_to_server_map; // Map to pair client and server sockets
std::unordered_map<int, int> server_to_client_map; // Map to pair server and client sockets

// Function to handle communication between client and server
void handle_client_server(int client_socket, int server_socket) {
    char buffer[1024];
    int bytes_read;

    while ((bytes_read = recv(client_socket, buffer, sizeof(buffer), 0)) > 0) {
        send(server_socket, buffer, bytes_read, 0);
        bytes_read = recv(server_socket, buffer, sizeof(buffer), 0);
        send(client_socket, buffer, bytes_read, 0);
    }

    // Remove mappings when connection is closed
    client_to_server_map.erase(client_socket);
    server_to_client_map.erase(server_socket);

    close(client_socket);
    close(server_socket);
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

    // Accept incoming connections and handle them
    while (true) {
        sockaddr_in client_address;
        socklen_t client_addrlen = sizeof(client_address);
        int client_socket = accept(server_socket_in, (struct sockaddr *)&client_address, &client_addrlen);
        if (client_socket == -1) {
            std::cerr << "Accept failed for incoming connections" << std::endl;
            close(server_socket_in);
            return 1;
        }

        // Create socket for outgoing connection to server
        int server_socket_out = socket(AF_INET, SOCK_STREAM, 0);
        if (server_socket_out == -1) {
            std::cerr << "Error creating socket for outgoing connection to server" << std::endl;
            close(client_socket);
            continue;
        }

        // Connect to server
        sockaddr_in server_address_out;
        server_address_out.sin_family = AF_INET;
        server_address_out.sin_addr.s_addr = inet_addr("127.0.0.1"); // IP of server
        server_address_out.sin_port = htons(PORT_OUT);
        if (connect(server_socket_out, (struct sockaddr *)&server_address_out, sizeof(server_address_out)) == -1) {
            std::cerr << "Connect failed for outgoing connection to server" << std::endl;
            close(client_socket);
            close(server_socket_out);
            continue;
        }

        // Store mappings between client and server sockets
        client_to_server_map[client_socket] = server_socket_out;
        server_to_client_map[server_socket_out] = client_socket;

        // Start thread to handle communication between client and server
        std::thread(handle_client_server, client_socket, server_socket_out).detach();
    }

    return 0;
}
