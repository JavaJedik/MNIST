#include <iostream>
#include <thread>
#include <vector>
#include <cstring>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h> // Hozzáadtuk ezt a sort

#define MAX_CONNECTIONS 10

void handle_connection(int client_socket, int server_socket) {
    char buffer[4096];
    while (true) {
        memset(buffer, 0, 4096);
        int bytesReceived = recv(client_socket, buffer, 4096, 0);
        if (bytesReceived <= 0) {
            break;
        }
        send(server_socket, buffer, bytesReceived, 0);
    }
    close(client_socket);
    close(server_socket);
}

int main() {
    int listening = socket(AF_INET, SOCK_STREAM, 0);
    sockaddr_in hint;
    hint.sin_family = AF_INET;
    hint.sin_port = htons(8815);
    inet_pton(AF_INET, "0.0.0.0", &hint.sin_addr);

    bind(listening, (struct sockaddr*)&hint, sizeof(hint));
    listen(listening, MAX_CONNECTIONS);

    std::vector<std::thread> threads;

    while (true) {
        int client_socket = accept(listening, NULL, NULL);
        int server_socket = socket(AF_INET, SOCK_STREAM, 0);
        sockaddr_in server_hint;
        server_hint.sin_family = AF_INET;
        server_hint.sin_port = htons(8814);
        inet_pton(AF_INET, "127.0.0.1", &server_hint.sin_addr);
        connect(server_socket, (struct sockaddr*)&server_hint, sizeof(server_hint));

        threads.push_back(std::thread(handle_connection, client_socket, server_socket));
    }

    for (auto& thread : threads) {
        thread.join();
    }

    return 0;
}
