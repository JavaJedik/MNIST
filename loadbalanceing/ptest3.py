import socket

SERVER_HOST = '127.0.0.1'
SERVER_PORT = 8814
LOAD_BALANCER_PORT = 8815

def main():
    # Create a socket for the load balancer
    load_balancer_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    load_balancer_socket.bind(('127.0.0.1', LOAD_BALANCER_PORT))
    load_balancer_socket.listen(1)
    
    print(f"Load balancer listening on port {LOAD_BALANCER_PORT}")
    
    # Accept connections from clients
    while True:
        client_socket, client_addr = load_balancer_socket.accept()
        print(f"Client connected: {client_addr}")
        
        # Connect to the server
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_socket.connect((SERVER_HOST, SERVER_PORT))
        
        # Forward data between client and server
        forward_data(client_socket, server_socket)
        
        # Close sockets
        client_socket.close()
        server_socket.close()

def forward_data(client_socket, server_socket):
    while True:
        # Receive data from the client
        client_data = client_socket.recv(4096)
        if not client_data:
            break
        
        # Forward data to the server
        server_socket.sendall(client_data)
        
        # Receive data from the server
        server_data = server_socket.recv(4096)
        if not server_data:
            break
        
        # Forward data to the client
        client_socket.sendall(server_data)

if __name__ == "__main__":
    main()
