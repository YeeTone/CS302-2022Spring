#include <stdio.h> 
#include <unistd.h> 

int main(int argc, char *argv[]){ 
	printf("A\n"); 
	//printf("%d",fork()); 
	fork();
	printf("B\n");
	fork(); 
	//printf("%d",fork()); 
	printf("C\n"); 
	return 0; 
}
