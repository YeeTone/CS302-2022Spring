#include<stdio.h> 
#include<unistd.h> 

int main(){ 
	if(fork()){ 
		printf("I'm parent process.\n"); 
	}else{
		printf("I'm child process.\n"); 
	}
	
	return 0; 
}
