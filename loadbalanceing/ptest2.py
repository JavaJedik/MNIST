import socket
import threading

# Szerver IP-címe és portszáma
SERVER_HOST = '127.0.0.1'
SERVER_PORT = 8814

# Kliens-kiszolgáló függvény
def handle_client(client_socket):
    while True:
        data = client_socket.recv(4096)
        if not data:
            break
        print(f"Received data from client: {data.decode()}")
        # Ide írd, hogy mit csináljon a kapott adatokkal
        # Például továbbíthatja egy másik szerver felé
        client_socket.sendall(data)  # Válasz küldése a kliensnek
    client_socket.close()

# Fő program
def main():
    # Szerver létrehozása
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((SERVER_HOST, SERVER_PORT))
    server_socket.listen(5)
    print(f"Server listening on port {SERVER_PORT}")

    # Kliensek fogadása és kezelése
    while True:
        client_socket, addr = server_socket.accept()
        print(f"Client connected from {addr}")
        threading.Thread(target=handle_client, args=(client_socket,)).start()

if __name__ == "__main__":
    main()

