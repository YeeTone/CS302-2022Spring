// kern/sync/check_exercise.c
#include <stdio.h>
#include <proc.h>
#include <sem.h>
#include <assert.h>
#include <condvar.h>

struct proc_struct *pworker1,*pworker2,*pworker3;
semaphore_t overallMutex;
condvar_t ws[3];

int index = 0;

void worker1(int i)
{
    
    while (1)
    {   
        cond_wait(&(ws[0]), &overallMutex);
        cprintf("make a bike rack\n");
        index++;
        index %=3;
        cond_signal(&(ws[index]));

    }
}

void worker2(int i)
{
    while (1)
    {  
        cond_wait(&(ws[1]), &overallMutex);      
        cprintf("make two wheels\n");
        index++;
        index %=3;
        cond_signal(&(ws[index]));
    }
}

void worker3(int i){
    while (1)
    {
        cond_wait(&ws[2], &overallMutex);
        cprintf("assemble a bike\n");
        index++;
        index %=3;
        cond_signal(&(ws[index]));
    }
}


void check_exercise(void){

	//initial
	sem_init(&(overallMutex), 0);
    cond_init(&(ws[0]));
    cond_init(&(ws[1]));
    cond_init(&(ws[2]));
    cond_signal(&(ws[index]));
    int pids[3];
    int i =0;
    pids[0]=kernel_thread(worker1, (void *)i, 0);
    pids[1]=kernel_thread(worker2, (void *)i, 0);
    pids[2]=kernel_thread(worker3, (void *)i, 0);
    pworker1 = find_proc(pids[0]);
    set_proc_name(pworker1, "worker1");
    pworker2 = find_proc(pids[1]);
    set_proc_name(pworker2, "worker2");
    pworker3 = find_proc(pids[2]);
    set_proc_name(pworker3, "worker3");
}
