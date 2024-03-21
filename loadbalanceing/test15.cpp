#include <iostream>
#include <vector>
#include <thread>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

const int LB_PORT = 8815; // Port for load balancer
const int SERVER_PORT = 8814; // Port for servers

std::vector<int> server_sockets; // List of server sockets

// Function to handle client connections
void handle_client(int client_socket) {
    // Choose server based on round-robin scheduling
    static int current_server = 0;
    int server_socket = server_sockets[current_server];
    current_server = (current_server + 1) % server_sockets.size();

    char buffer[1024];
    int bytes_received;

    while ((bytes_received = recv(client_socket, buffer, sizeof(buffer), 0)) > 0) {
        int bytes_sent = send(server_socket, buffer, bytes_received, 0);
        if (bytes_sent != bytes_received) {
            std::cerr << "Error sending data to server" << std::endl;
            break;
        }
    }

    close(client_socket);
}

int main() {
    // Create socket for load balancer
    int lb_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (lb_socket == -1) {
        std::cerr << "Error creating socket for load balancer" << std::endl;
        return 1;
    }

    // Prepare the sockaddr_in structure
    sockaddr_in lb_address;
    lb_address.sin_family = AF_INET;
    lb_address.sin_addr.s_addr = INADDR_ANY;
    lb_address.sin_port = htons(LB_PORT);

    // Bind
    if (bind(lb_socket, (struct sockaddr *)&lb_address, sizeof(lb_address)) == -1) {
        std::cerr << "Bind failed for load balancer" << std::endl;
        close(lb_socket);
        return 1;
    }

    // Listen
    if (listen(lb_socket, 3) == -1) {
        std::cerr << "Listen failed for load balancer" << std::endl;
        close(lb_socket);
        return 1;
    }

    std::cout << "Load balancer listening on port " << LB_PORT << std::endl;

    // Accept incoming client connections and handle them
    while (true) {
        sockaddr_in client_addr;
        socklen_t client_addrlen = sizeof(client_addr);
        int client_connection = accept(lb_socket, (struct sockaddr *)&client_addr, &client_addrlen);
        if (client_connection == -1) {
            std::cerr << "Accept failed for client connections" << std::endl;
            continue;
        }

        std::cout << "Client connected" << std::endl;

        std::thread(handle_client, client_connection).detach();
    }

    close(lb_socket);

    return 0;
}
