#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main(){

	pid_t pid = fork();
	
	if(pid == 0){
		printf("Child! pid = %d\n", getpid());
		
		execl("/bin/ps","/bin/ps", "al", NULL);
		
		printf("Child has dead!\n");
	}else {
		printf("Parent! pid = %d\n", getpid());
		
		printf("Parent is waiting ...\n");
		
		wait(NULL);
		
		printf("Parent has dead!\n");
	}
	
	return 0;
}
