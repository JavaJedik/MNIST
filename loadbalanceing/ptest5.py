import socket
import threading

def forward_data(source, destination):
    while True:
        data = source.recv(4096)
        if not data:
            break  # Nincs több adat, zárjuk le a kapcsolatot
        destination.send(data)

def handle_client(client_socket, target_host, target_port):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.connect((target_host, target_port))
    # Kliensből szerverre irányuló adatfolyam
    client_to_server = threading.Thread(target=forward_data, args=(client_socket, server_socket))
    # Szerverből kliensre irányuló adatfolyam
    server_to_client = threading.Thread(target=forward_data, args=(server_socket, client_socket))
    client_to_server.start()
    server_to_client.start()
    client_to_server.join()
    server_to_client.join()
    client_socket.close()
    server_socket.close()

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
