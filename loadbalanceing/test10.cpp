#include <iostream>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <thread>
#include <vector>
#include <unordered_map>

const int PORT = 8815;
const int BACKLOG = 5;

std::unordered_map<int, std::thread> client_threads;

void handle_client(int client_socket) {
    char buffer[1024];
    while (true) {
        int bytes_received = recv(client_socket, buffer, sizeof(buffer), 0);
        if (bytes_received <= 0) {
            std::cerr << "Error receiving data from client" << std::endl;
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
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        std::cerr << "Error creating server socket" << std::endl;
        return 1;
    }

    sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(PORT);

    if (bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address)) == -1) {
        std::cerr << "Bind failed" << std::endl;
        close(server_socket);
        return 1;
    }

    if (listen(server_socket, BACKLOG) == -1) {
        std::cerr << "Listen failed" << std::endl;
        close(server_socket);
        return 1;
    }

    std::cout << "Server listening on port " << PORT << std::endl;

    while (true) {
        sockaddr_in client_address;
        socklen_t client_addrlen = sizeof(client_address);
        int client_socket = accept(server_socket, (struct sockaddr *)&client_address, &client_addrlen);
        if (client_socket == -1) {
            std::cerr << "Accept failed" << std::endl;
            continue;
        }

        if (client_threads.find(client_socket) == client_threads.end()) {
            // If client socket doesn't exist in map, start new thread
            std::thread client_thread(handle_client, client_socket);
            client_threads[client_socket] = std::move(client_thread);
        } else {
            std::cerr << "Client socket already exists" << std::endl;
            close(client_socket);
        }
    }

    // Clean up threads
    for (auto& pair : client_threads) {
        pair.second.join();
    }

    close(server_socket);
    return 0;
}
