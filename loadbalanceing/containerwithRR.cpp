#include <iostream>
#include <thread>
#include <vector>
#include <cstring>
#include <netinet/tcp.h> // TCP_KEEPIDLE-hez
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <atomic>
#include <sys/socket.h>

std::vector<std::pair<std::string, int>> servers = {{"127.0.0.1", 8816}};
std::atomic<size_t> server_index{0};
std::atomic<int> activeConnections{0};
static const int loadBalancerPort=8814;
static int maxQueueSize=100;

void configureKeepAlive(int sock) {
    int optval = 1;
    socklen_t optlen = sizeof(optval);

    if (setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, &optval, optlen) < 0) {
        std::cerr << "Error setting TCP keep-alive." << std::endl;
    }

    optval = 60; // 60 másodperc inaktivitási idő
    if (setsockopt(sock, IPPROTO_TCP, TCP_KEEPIDLE, &optval, optlen) < 0) {
        std::cerr << "Error setting TCP keep-alive idle time." << std::endl;
    }
}

void forwardData(int sourceSock, int destSock, std::thread::id threadId) {
    char buffer[4096];
    size_t totalBytes = 0;

    while (true) {
        ssize_t bytesRead = read(sourceSock, buffer, sizeof(buffer));
        if (bytesRead <= 0) break;
        totalBytes += bytesRead;

        ssize_t bytesWritten = write(destSock, buffer, bytesRead);
        if (bytesWritten <= 0) break;
    }

    std::cout << "[" << threadId << "] Kapcsolat lezárva, összesen " << totalBytes << " byte adat átvitelre került." << std::endl;

    activeConnections--; int numberOfConnections = activeConnections.load(); // Konkorens hozzáférés elkerülése
    std::cout << "[" << threadId << "] Jelenleg aktív (kliens+szerver) kapcsolatok száma: " << numberOfConnections << " (" << int(numberOfConnections/2) << ")" << std::endl;

    close(sourceSock);
    close(destSock);
}

void handleClient(int clientSock, sockaddr_in clientAddr) {
    std::thread::id threadId = std::this_thread::get_id();
    configureKeepAlive(clientSock);

    std::cout << "[" << threadId << "] Kliens csatlakozott: " << inet_ntoa(clientAddr.sin_addr) << ":" << ntohs(clientAddr.sin_port) << std::endl;

    size_t currentIndex = server_index.fetch_add(1) % servers.size();
    auto [targetHost, targetPort] = servers[currentIndex];
    std::cout << "[" << threadId << "] Továbbítás a szerverre: " << targetHost << ":" << targetPort << std::endl;

    int serverSock = socket(AF_INET, SOCK_STREAM, 0);
    configureKeepAlive(serverSock);

    sockaddr_in serverAddr;
    memset(&serverAddr, 0, sizeof(serverAddr));
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(targetPort);
    inet_pton(AF_INET, targetHost.c_str(), &serverAddr.sin_addr);

    if (connect(serverSock, (sockaddr*)&serverAddr, sizeof(serverAddr)) < 0) {
        std::cerr << "[" << threadId << "] Nem sikerült csatlakozni a szerverhez: " << targetHost << ":" << targetPort << std::endl;
        close(clientSock);
        return;
    }

    std::thread clientToServerThread(forwardData, clientSock, serverSock, threadId);
    std::thread serverToClientThread(forwardData, serverSock, clientSock, threadId);

    activeConnections = activeConnections+2; int numberOfConnections =  activeConnections.load(); // A szerver-kliens pár miatt, és a konkorens írások elkerülésére
    std::cout << "[" << std::this_thread::get_id() << "] Jelenleg aktív (kliens+szerver) kapcsolatok száma: " << numberOfConnections << " (" << int(numberOfConnections/2) << ")" << std::endl;

    clientToServerThread.join();
    serverToClientThread.join();
}

int main() {
    int loadBalancerSock = socket(AF_INET, SOCK_STREAM, 0);
    sockaddr_in loadBalancerAddr;
    memset(&loadBalancerAddr, 0, sizeof(loadBalancerAddr));
    loadBalancerAddr.sin_family = AF_INET;
    loadBalancerAddr.sin_port = htons(loadBalancerPort);
    loadBalancerAddr.sin_addr.s_addr = INADDR_ANY;

    if (bind(loadBalancerSock, (sockaddr*)&loadBalancerAddr, sizeof(loadBalancerAddr)) < 0) {
        std::cerr << "Binding failed." << std::endl;
        return -1;
    }

    listen(loadBalancerSock, maxQueueSize);
    std::cout << "Load balancer is listening on port " << loadBalancerPort << "..." << std::endl;

    while (true) {
        sockaddr_in clientAddr;
        socklen_t clientAddrLen = sizeof(clientAddr);
        int clientSock = accept(loadBalancerSock, (sockaddr*)&clientAddr, &clientAddrLen);

        if (clientSock < 0) {
            std::cerr << "Accept failed." << std::endl;
            continue;
        }

        std::thread clientThread([clientSock, clientAddr](){ handleClient(clientSock, clientAddr); });
        clientThread.detach(); // Leválasztjuk a szálat, hogy párhuzamosan tudjon futni, nem várjuk meg a befejezését
    }

    close(loadBalancerSock);
    return 0;
}

