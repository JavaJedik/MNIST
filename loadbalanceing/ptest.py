import socket
import random

# Szerverek listája és az index
SERVERS = [('127.0.0.1', 8814), ('127.0.0.1', 8816)]

# Kliens-kiszolgáló függvény
def handle_client(client_socket):
    # Válassz egy véletlenszerű szervert a listából
    server_host, server_port = random.choice(SERVERS)
    
    # Nyit egy új kapcsolatot a választott szerverrel
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.connect((server_host, server_port))
    
    # Továbbítás a kliens és a szerver között
    while True:
        # Fogad adatokat a kliensről
        client_data = client_socket.recv(4096)
        if not client_data:
            break
        # Küldje el az adatokat a kiválasztott szervernek
        server_socket.sendall(client_data)
        
        # Fogad adatokat a szerverről
        server_data = server_socket.recv(4096)
        if not server_data:
            break
        # Küldje vissza az adatokat a kliensnek
        client_socket.sendall(server_data)
    
    # Kapcsolatok lezárása
    client_socket.close()
    server_socket.close()

# Fő program
def main():
    # Elosztó szerver létrehozása
    lb_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    lb_socket.bind(('127.0.0.1', 8815))
    lb_socket.listen(5)
    print("Load balancer listening on port 8815")
    
    # Kliensek fogadása és kezelése
    while True:
        client_socket, addr = lb_socket.accept()
        print(f"Client connected from {addr}")
        handle_client(client_socket)

if __name__ == "__main__":
    main()
