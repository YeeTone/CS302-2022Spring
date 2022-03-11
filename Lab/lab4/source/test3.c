#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>

int main(void){
	int pid = fork();
	if(pid == 0){
		sleep(10);
		printf("This is a child. Child pid = %d, ppid = %d\n", getpid(), getppid());
	}else {
		printf("This is a parent. Child = %d, pid = %d, ppid = %d\n",pid , getpid(), getppid());
		printf("After child ends.\n");
	}
	printf("Which process?\n");
	
	return 0;
}
