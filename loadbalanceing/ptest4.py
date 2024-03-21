import socket
import threading

def handle_client(client_socket, target_host, target_port):
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.connect((target_host, target_port))
    while True:
        # Kliensből érkező adatok fogadása
        request = client_socket.recv(1024)
        if not request:
            break
        # Adatok továbbítása a szerver felé
        server.send(request)
        # Válasz fogadása a szervertől
        response = server.recv(4096)
        # Válasz küldése vissza a kliensnek
        client_socket.send(response)
    client_socket.close()
    server.close()

def main():
    load_balancer = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    load_balancer.bind(("", 8815))  # Figyelés az 8815-ös porton
    load_balancer.listen(5)
    print("Load balancer is listening on port 8815...")

    while True:
        client, addr = load_balancer.accept()
        print(f"Accepted connection from {addr[0]}:{addr[1]}")
        client_handler = threading.Thread(target=handle_client, args=(client, "localhost", 8814))
        client_handler.start()

if __name__ == "__main__":
    main()
