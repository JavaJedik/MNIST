#include <iostream>
#include <thread>
#include <vector>
#include <cstring>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <atomic>

std::vector<std::pair<std::string, int>> servers = {{"127.0.0.1", 8814},{"127.0.0.1", 8816}};
std::atomic<size_t> server_index{0};  // Atomikus, hogy szálbiztos legyen

void forwardData(int sourceSock, int destSock, std::thread::id threadId) {
    char buffer[4096];
    size_t totalBytes = 0;
    while (true) {
        ssize_t bytesRead = read(sourceSock, buffer, sizeof(buffer));
        if (bytesRead <= 0) break;  // Ha nincs több adat, vagy hiba történt
        totalBytes += bytesRead;

        ssize_t bytesWritten = write(destSock, buffer, bytesRead);
        if (bytesWritten <= 0) break;  // Ha hiba történt az írás során
    }
    
    std::cout << "[" << threadId << "] Kapcsolat lezárva, összesen " << totalBytes << " byte adat átvitelre került." << std::endl;
    close(sourceSock);
    close(destSock);
}

void handleClient(int clientSock, sockaddr_in clientAddr) {
    std::thread::id threadId = std::this_thread::get_id();
    std::cout << "[" << threadId << "] Kliens csatlakozott: " << inet_ntoa(clientAddr.sin_addr) << ":" << ntohs(clientAddr.sin_port) << std::endl;

    size_t currentIndex = server_index.fetch_add(1) % servers.size();
    auto [targetHost, targetPort] = servers[currentIndex];
    std::cout << "[" << threadId << "] Továbbítás a szerverre: " << targetHost << ":" << targetPort << std::endl;

    int serverSock = socket(AF_INET, SOCK_STREAM, 0);
    sockaddr_in serverAddr;
    memset(&serverAddr, 0, sizeof(serverAddr));  // A struktúra nullázása
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(targetPort);
    inet_pton(AF_INET, targetHost.c_str(), &serverAddr.sin_addr);  // Cím átalakítása

    if (connect(serverSock, (sockaddr*)&serverAddr, sizeof(serverAddr)) < 0) {
        std::cerr << "[" << threadId << "] Nem sikerült csatlakozni a szerverhez: " << targetHost << ":" << targetPort << std::endl;
        close(clientSock);
        return;
    }

    std::thread clientToServerThread(forwardData, clientSock, serverSock, threadId);
    std::thread serverToClientThread(forwardData, serverSock, clientSock, threadId);

    clientToServerThread.join();
    serverToClientThread.join();
}

int main() {
    int loadBalancerSock = socket(AF_INET, SOCK_STREAM, 0);
    sockaddr_in loadBalancerAddr;
    memset(&loadBalancerAddr, 0, sizeof(loadBalancerAddr));  // A struktúra nullázása
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

        std::thread clientThread([clientSock, clientAddr](){ handleClient(clientSock, clientAddr); });
        clientThread.detach();  // Leválasztjuk a szálat, hogy párhuzamosan tudjon futni, nem várjuk meg a befejezését
    }

    close(loadBalancerSock);
    return 0;
}
