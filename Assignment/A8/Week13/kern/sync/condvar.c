#include <stdio.h>
#include <condvar.h>
#include <kmalloc.h>
#include <assert.h>

void     
cond_init (condvar_t *cvp) {
//================your code=====================
    sem_init(&(cvp->sem), 0);
}

// Unlock one of threads waiting on the condition variable. 
void 
cond_signal (condvar_t *cvp) {
//================your code=====================
    up(&(cvp->sem));

}

void
cond_wait (condvar_t *cvp,semaphore_t *mutex) {
//================your code=====================
    up(mutex);
    down(&(cvp->sem));
    down(mutex);
    
}

// reference1: https://github.com/Trinkle23897/os2019/blob/0274c5919a8356081e3c838fa1277394ff78cd54/labcodes/lab7/lab7.md
// reference2: https://chyyuu.gitbooks.io/ucore_os_docs/content/lab7/lab7_3_4_monitors.html
