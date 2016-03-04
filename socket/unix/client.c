#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#define PORT 9876 //set the same number as server 

int main(){
	// IP adress，socket，sockaddr_in 構造体
	char destination[32];
	int dstSocket;
	struct sockaddr_in dstAddr;

	//struct sockaddr_in addr;
	struct hostent *hp;
	char   buf[1024];
	int    numrcv;

	printf("insert the IPadrress of the server machine？:");
	scanf("%s", destination);

	//sockaddr_in 構造体のセット
	bzero((char *)&dstAddr, sizeof(dstAddr));
	dstAddr.sin_family = AF_INET;
	dstAddr.sin_port = htons(PORT);

	hp = gethostbyname(destination);
	bcopy(hp->h_addr, &dstAddr.sin_addr, hp->h_length);

	dstSocket = socket(AF_INET, SOCK_STREAM, 0);

	//xonnect
	if (connect(dstSocket, (struct sockaddr *)&dstAddr, sizeof(dstAddr)) < 0){
		printf("Failed to establish the connection to %s\n", destination);
		return(-1);
	}
	printf("Connection established to %s \n", destination);
	printf("insert an char\n");

	while (1){
		scanf("%s", buf);
		// send packet
		write(dstSocket, buf, 1024);
		// recieve packet
		numrcv = read(dstSocket, buf, 1024);
		printf("→ %s\n\n", buf);
	}
	close(dstSocket);
	return(0);
}