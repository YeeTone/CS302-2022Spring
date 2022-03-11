#include<stdio.h> 
#include<unistd.h> 
int main(){ 
	int i = 0; fork(); //创建子进程 
	i++; 
	printf("%d\n", i); 
	while(1); 
	return 0; 
	
}
