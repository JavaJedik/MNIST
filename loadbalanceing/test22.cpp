#include <iostream>
#include <thread>
#include <mutex>
#include <vector>
#include <atomic>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

constexpr int MAX_BUFFER_SIZE = 1024;
constexpr int BACKLOG = 10;
constexpr int NUM_WORKER_THREADS = 4;
constexpr int SERVER_PORT = 8080;

std::atomic<bool> stop(false);
std::mutex mutex;

void handle_client(int client_socket) {
    char buffer[MAX_BUFFER_SIZE];
    ssize_t bytes_received;
    while (!stop) {
        bytes_received = recv(client_socket, buffer, sizeof(buffer), 0);
        if (bytes_received == 0 || bytes_received == -1) {
            break;
        }

        // Itt feldolgozhatod a bejövő adatokat, és válaszolhatsz a kliensnek

        send(client_socket, buffer, bytes_received, 0);
    }
    close(client_socket);
}

void load_balancer() {
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        std::cerr << "Error creating server socket" << std::endl;
        return;
    }

    sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(SERVER_PORT);

    if (bind(server_socket, reinterpret_cast<sockaddr*>(&server_address), sizeof(server_address)) == -1) {
        std::cerr << "Error binding server socket" << std::endl;
        close(server_socket);
        return;
    }

    if (listen(server_socket, BACKLOG) == -1) {
        std::cerr << "Error listening on server socket" << std::endl;
        close(server_socket);
        return;
    }

    while (!stop) {
        int client_socket = accept(server_socket, nullptr, nullptr);
        if (client_socket == -1) {
            std::cerr << "Error accepting client connection" << std::endl;
            continue;
        }
        
        std::thread(handle_client, client_socket).detach();
    }

    close(server_socket);
}

int main() {
    std::vector<std::thread> worker_threads;
    for (int i = 0; i < NUM_WORKER_THREADS; ++i) {
        worker_threads.emplace_back(load_balancer);
    }

    std::cout << "Load balancer started on port " << SERVER_PORT << std::endl;
    std::cout << "Press enter to stop..." << std::endl;
    std::cin.get();

    stop = true;
    for (auto& thread : worker_threads) {
        thread.join();
    }

    return 0;
}
