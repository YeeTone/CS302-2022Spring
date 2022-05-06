/*dad_mem_mutex.c*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <time.h> 
#include <sys/stat.h>

#include <pthread.h> 
#include <unistd.h> 
#include <sys/types.h>

int youDrink = 0, dadDrink = 0;

int fd;
int milk;
int cond_signal = 0;
pthread_mutex_t mutex = PTHREAD_MUTsEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

int check_fridge(){
    fd=open("fridge", O_CREAT|O_RDWR|O_APPEND, 0777);
    milk = lseek(fd, 0, SEEK_END);
    close(fd);
    return milk;
}

void take_milk(){
    fd=open("fridge", O_CREAT|O_RDWR|O_APPEND, 0777);
    write(fd,"milk",milk-1);
    milk--;
    close(fd);
    
}

void buy_milk(){
    fd=open("fridge", O_CREAT|O_RDWR|O_APPEND, 0777);
    write(fd,"milk",5);
    milk = 5;
    close(fd);
}

void *mom(){
    sleep(rand()%2+1);
    while(1) {
        pthread_mutex_lock(&mutex);
        while(check_fridge() > 0){
            pthread_cond_wait(&cond, &mutex);
        }

        printf("Mom is going to buy milk\n");

        buy_milk();
        pthread_mutex_unlock(&mutex);
    }
    
}

void *sister(){
    sleep(rand()%2+1);
    while(1) {
        pthread_mutex_lock(&mutex);
        while(check_fridge() > 0){
            pthread_cond_wait(&cond, &mutex);
        }

        printf("Sister is going to buy milk\n");

        buy_milk();
        pthread_mutex_unlock(&mutex);
    }
    
}

void *you(){
    sleep(rand()%2+1);
    while(1){
        pthread_mutex_lock(&mutex);
        int num = check_fridge();
        if(num > 0) {
            
            take_milk();
            youDrink++;
            printf("You are drinking milk, %d times\n", youDrink);
            if(youDrink >= 5){
                exit(0);
            }
        }else {
            //printf("You cannot get any milk, sorry...\n");
            pthread_cond_signal(&cond);
        }

        pthread_mutex_unlock(&mutex);
    }
}

void *dad(){
    sleep(rand()%2+1);
    while(1){
        pthread_mutex_lock(&mutex);
        int num = check_fridge();
        if(num > 0) {
            take_milk();
            dadDrink++;
            printf("Dad is drinking milk, %d times\n", dadDrink);
            if(dadDrink >= 5){
                exit(0);
            }
        }else {
            //printf("Dad cannot get any milk, sorry...\n");
            pthread_cond_signal(&cond);
        }

        pthread_mutex_unlock(&mutex);
    }
}

int main(int argc, char * argv[]) {
    srand(time(0));
    pthread_t p1, p2, p3, p4;
    int fd = open("fridge", O_CREAT|O_RDWR|O_TRUNC , 0777);  //empty the fridge
    close(fd);
    // Create four threads (both run func)  
    pthread_create(&p2, NULL, you, NULL); 
    
    pthread_create(&p2, NULL, dad, NULL); 

    pthread_create(&p1, NULL, mom, NULL); 
    pthread_create(&p2, NULL, sister, NULL);
    
  
    // Wait for the threads to end. 
    pthread_join(p1, NULL); 
    pthread_join(p2, NULL); 
}