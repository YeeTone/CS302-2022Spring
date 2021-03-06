# Assignment8 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## 1. I/O

### (1) What are the pros and cons of polling and interrupt-based I/O?

For the polling I/O:
- Pros: It can make interaction of device efficiently. This can be seen in the 3rd page in the book chapter:
![image](https://user-images.githubusercontent.com/64548919/168814485-f2d38d9c-e93e-4be6-9e16-25def5308014.png)

- Cons: Consider the following in the 4th page in the book chapter:

![image](https://user-images.githubusercontent.com/64548919/168805625-c667b595-8936-4b10-a0d6-4bed6c374333.png)

2 aspects:
1. polling is inefficient
2. polling wastes too much CPU time, just for waiting for the device to finish the tasks.

For the interrpt-based I/O:
- Pros: Interrupts can allow the overlap for computation and I/O, thus can improve the utilization. It can be seen in the 5th page in the book chapter:
![image](https://user-images.githubusercontent.com/64548919/168814648-98da3ab8-3a3c-45d3-bab7-c187a500bedb.png)

- Cons: Consider the following in the 6th page in the book chapter

![image](https://user-images.githubusercontent.com/64548919/168811896-18bf7306-5fe3-49d0-95ea-f05ed30597aa.png)

![image](https://user-images.githubusercontent.com/64548919/168812083-e7ad0105-a07b-4f0c-834c-d5a04a8476a3.png)

2 aspects:
1. it slows down the system which performs the tasks quickly.
2. in network, it does not allow the user-level process to run and service the requests when it is handling the interrupts.


### (2) What are the differences between PIO and DMA?
PIO: Programming I/O. This refers to the data movement from the disk device to the device with the main CPU involved.

![image](https://user-images.githubusercontent.com/64548919/168821508-168f3504-aa35-4d3a-a959-ef96b7adca01.png)


DMA: Direct Memory Access. This refers to the progress of data movement from the device to the main memory, without much CPU involvation involvement.

![image](https://user-images.githubusercontent.com/64548919/168821411-09962561-3d94-4206-a726-5dafd293b74d.png)

Differences:
1. DMA can have better performance than PIO in the usual case. Since PIO may use CPU while DMA not, CPU is slower than DMA.
2. PIO is much cheaper than DMA, in the area of circuitry design. Thus in the devices not necessary to have great performance, PIO has better cost performance than DMA.

> Reference: http://www.differencebetween.net/technology/difference-between-dma-and-pio/

### (3) How to protect memory-mapped I/O and explicit I/O instructions from being abused by malicious user process?

For the memory-mapped I/O, consider the following statements in the page 8 in the book chapter: 

![image](https://user-images.githubusercontent.com/64548919/169641693-8b0cea05-e9b4-4227-a827-5f21ce078e5a.png)

To use memory-mapped I/O, the hardware needs to make the reigsters available. And in order to access the register, the OS needs to issue load/store instruction to the address. Thus it must be controlled by OS and can be protected from being abused by user process.

Foe the explicit I/O, Consider the following statements in the page 8 in the book chapter: 

![image](https://user-images.githubusercontent.com/64548919/169641484-7184bd72-8e35-4f12-91ae-cb5fa36b465c.png)

we let these instructions become privileged thus only OS can invoke these instructions.

## 2. Condition variable
- Design idea: Just encapsulate one semaphore in the condvar_t. For the signal function, just activate the semaphore inside the condvar_t. 
For the wait function, first release the mutex, then deactivate the semaphore, finally deactivate the mutex.

- Code screeshots:

condvar.h:

![image](https://user-images.githubusercontent.com/64548919/169640876-ddd7af7d-b915-4500-94c5-1151b1a3530b.png)

condvar.c:

![image](https://user-images.githubusercontent.com/64548919/169640895-793c3c46-c737-4322-81cd-945351943fff.png)

- Running result:

![image](https://user-images.githubusercontent.com/64548919/169640957-85a7faaf-8841-4375-8998-e09bf951cf32.png)

## 3. Bike

- Design idea: Use 1 overall mutex to represent the lock, and 3 condition variables to represent the lock for the 3 workers.

- Code screenshots:

check_exercise.c:

![image](https://user-images.githubusercontent.com/64548919/169641208-8756cc88-5870-47e7-99ac-881a04ab8518.png)

![image](https://user-images.githubusercontent.com/64548919/169641211-ce1a8976-addf-4afa-a2b0-911e4b474e81.png)

![image](https://user-images.githubusercontent.com/64548919/169641218-072e1bb3-b04e-4724-b1dc-459576a50c11.png)


- Running result:

![image](https://user-images.githubusercontent.com/64548919/169641185-ed900869-c358-47fc-8609-294b5ffb689b.png)

