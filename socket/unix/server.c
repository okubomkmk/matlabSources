#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define PORT 9876 //set the same number as client

int main(){
	int i;
	int srcSocket; //server
	int dstSocket; //ckuebt
	// sockaddr_in structur
	struct sockaddr_in srcAddr;
	struct sockaddr_in dstAddr;
	int dstAddrSize = sizeof(dstAddr);

	int status;
	int numrcv;
	char buf[1024];

	while (1){//do a roop for access
		// sockaddr_in 
		bzero((char *)&srcAddr, sizeof(srcAddr));
		srcAddr.sin_port = htons(PORT);
		srcAddr.sin_family = AF_INET;
		srcAddr.sin_addr.s_addr = INADDR_ANY;

		// make socket
		srcSocket = socket(AF_INET, SOCK_STREAM, 0);
		// bind socket
		bind(srcSocket, (struct sockaddr *)&srcAddr, sizeof(srcAddr));
		// accept the connection
		listen(srcSocket, 1);

		// connection
		printf("waiting for connection\nclient\n");
		dstSocket = accept(srcSocket, (struct sockaddr *)&dstAddr, &dstAddrSize);
		printf("Accepted an access from %s \n", inet_ntoa(dstAddr.sin_addr));
		close(srcSocket);

		while (1){
			//recieve a packet
			numrcv = read(dstSocket, buf, 1024);
			if (numrcv == 0 || numrcv == -1){
				close(dstSocket); break;
			}
			printf("before conversion %s", buf);
			for (i = 0; i< numrcv; i++){ // convert
				if (isalpha(buf[i])) buf[i] = toupper(buf[i]);
			}
			// send packet
			write(dstSocket, buf, 1024);
			fprintf(stdout, "after convert %s \n", buf);
		}
	}
	return(0);
}