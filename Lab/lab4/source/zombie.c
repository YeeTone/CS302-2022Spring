#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main(){

	pid_t pid = fork();
	
	if(pid == 0){
		printf("Child! pid = %d\n", getpid());
		
		sleep(5);
		
		printf("Child has dead!\n");
	}else {
		printf("Parent! pid = %d\n", getpid());
		
		sleep(25);
		
		printf("Parent has dead!\n");
	}
	
	return 0;
}
