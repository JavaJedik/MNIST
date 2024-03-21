#include <iostream>
#include <thread>
#include <vector>
#include <cstring>
#include <netinet/in.h>
#include <unistd.h>
#include <arpa/inet.h>

std::vector<std::pair<std::string, int>> servers = {{"127.0.0.1", 8814}};
size_t server_index = 0;  // A következő szerver indexe

void forwardData(int sourceSock, int destSock) {
    char buffer[4096];
    while (true) {
        ssize_t bytesRead = read(sourceSock, buffer, sizeof(buffer));
        if (bytesRead <= 0) break;  // Ha nincs több adat, vagy hiba történt

        ssize_t bytesWritten = write(destSock, buffer, bytesRead);
        if (bytesWritten <= 0) break;  // Ha hiba történt az írás során
    }

    close(sourceSock);
    close(destSock);
}

void handleClient(int clientSock) {
    auto [targetHost, targetPort] = servers[server_index];
    server_index = (server_index + 1) % servers.size();  // Következő szerver kiválasztása

    int serverSock = socket(AF_INET, SOCK_STREAM, 0);
    sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(targetPort);
    inet_pton(AF_INET, targetHost.c_str(), &serverAddr.sin_addr);

    if (connect(serverSock, (sockaddr*)&serverAddr, sizeof(serverAddr)) < 0) {
        std::cerr << "Connection to the server failed." << std::endl;
        close(clientSock);
        return;
    }

    std::thread clientToServerThread(forwardData, clientSock, serverSock);
    std::thread serverToClientThread(forwardData, serverSock, clientSock);

    clientToServerThread.join();
    serverToClientThread.join();
}

int main() {
    int loadBalancerSock = socket(AF_INET, SOCK_STREAM, 0);
    sockaddr_in loadBalancerAddr;
    loadBalancerAddr.sin_family = AF_INET;
    loadBalancerAddr.sin_port = htons(8815);
    loadBalancerAddr.sin_addr.s_addr = INADDR_ANY;

    if (bind(loadBalancerSock, (sockaddr*)&loadBalancerAddr, sizeof(loadBalancerAddr)) < 0) {
        std::cerr << "Binding failed." << std::endl;
        return -1;
    }

    listen(loadBalancerSock, 5);
    std::cout << "Load balancer is listening on port 8815..." << std::endl;

    while (true) {
        sockaddr_in clientAddr;
        socklen_t clientAddrLen = sizeof(clientAddr);
        int clientSock = accept(loadBalancerSock, (sockaddr*)&clientAddr, &clientAddrLen);

        if (clientSock < 0) {
            std::cerr << "Accept failed." << std::endl;
            continue;
        }

        std::thread clientThread(handleClient, clientSock);
        clientThread.detach();  // Leválasztjuk a szálat, hogy párhuzamosan tudjon futni
    }

    close(loadBalancerSock);
    return 0;
}
