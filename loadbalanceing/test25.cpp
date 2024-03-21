#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <thread>
#include <arpa/inet.h>

void handle_client(int client_sock, sockaddr_in server_addr) {
    int server_sock = socket(AF_INET, SOCK_STREAM, 0);
    if (server_sock < 0) {
        std::cerr << "Cannot create socket for server connection." << std::endl;
        return;
    }

    if (connect(server_sock, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        std::cerr << "Cannot connect to server." << std::endl;
        close(client_sock);
        return;
    }

    char buffer[4096];
    int bytes_read;
    while ((bytes_read = read(client_sock, buffer, sizeof(buffer))) > 0) {
        write(server_sock, buffer, bytes_read);
    }

    close(server_sock);
    close(client_sock);
}

int main() {
    int listen_sock = socket(AF_INET, SOCK_STREAM, 0);
    if (listen_sock < 0) {
        std::cerr << "Cannot create socket." << std::endl;
        return 1;
    }

    sockaddr_in listen_addr;
    memset(&listen_addr, 0, sizeof(listen_addr));
    listen_addr.sin_family = AF_INET;
    listen_addr.sin_addr.s_addr = INADDR_ANY;
    listen_addr.sin_port = htons(8815);

    if (bind(listen_sock, (struct sockaddr*)&listen_addr, sizeof(listen_addr)) < 0) {
        std::cerr << "Cannot bind socket." << std::endl;
        close(listen_sock);
        return 1;
    }

    if (listen(listen_sock, 5) < 0) {
        std::cerr << "Cannot listen on socket." << std::endl;
        close(listen_sock);
        return 1;
    }

    sockaddr_in server_addr;
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    server_addr.sin_port = htons(8814);

    std::cout << "Load balancer is listening on port 8815..." << std::endl;

    while (true) {
        int client_sock = accept(listen_sock, NULL, NULL);
        if (client_sock < 0) {
            std::cerr << "Cannot accept client connection." << std::endl;
            continue;
        }

        std::thread t(handle_client, client_sock, server_addr);
        t.detach();
    }

    close(listen_sock);
    return 0;
}
