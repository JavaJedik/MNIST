#include <iostream>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define PORT 8814

int main() {
    int server_fd, new_socket;
    struct sockaddr_in address;
    int addrlen = sizeof(address);

    // Socket létrehozása
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("socket failed");
        return 1;
    }

    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT);

    // Port foglalása
    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
        perror("bind failed");
        return 1;
    }

    // Kapcsolatok fogadása
    if (listen(server_fd, 5) < 0) {
        perror("listen");
        return 1;
    }

    // Kliens kapcsolat fogadása
    if ((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen)) < 0) {
        perror("accept");
        return 1;
    }

    // Ha ide eljutottunk, sikeresen fogadtunk egy új kapcsolatot
    std::cout << "Uj kapcsolat fogadva" << std::endl;

    // Kapcsolat kezelése

    // Kapcsolat lezárása
    close(new_socket);
    close(server_fd);

    return 0;
}

