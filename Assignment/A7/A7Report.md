# Assignment7 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1. Deadlock
### （1）Is the operating system in a safe state? Why？

This OS is in a safe state, since we can find an order of procress execution to let them get the resource one by one.

Currently, the resource condition is enumerated as following:
- P1: capture 0A 2B 1C 0D，require 2A 1B 0C 0D
- P2：capture 0A 1B 0C 1D，require 0A 0B 2C 1D
- P3：capture 0A 0B 1C 0D，require 1A 0B 0C 1D
- P4：capture 1A 1B 0C 0D，require 0A 1B 1C 1D
- Free Resource：1A 0B 1C 2D

We can see the free resource can meet the requirement of P3.

Thus we execute P3 first and the free resource become:

1A 0B 2C 2D

Similarly, we can execute P2 and the free resource become:

1A 1B 2C 3D

After that, P4 can also be run and make the free resource into:

2A 2B 2C 2D

Finally, P1 can be executed.

Therefore, the execution order is (P3, P2, P4, P1), and the system is in a safe mode.

### （2） If P4 requests (0,0,1,1), please run the Banker’s algorithm to determine if the request should be granted.
i. check the need and request:

request(P4) = (0, 0, 1, 1) <= (0, 1, 1, 1) = need(P4);

passed.

ii. check the available and request:

request(P4) = (0, 0, 1, 1) <= (1, 0, 1, 2) = available(P4)

passed

iii. check the deadlock.

First assume the allocation is successful.

Then the resource condition is changed into:
- P1: capture 0A 2B 1C 0D，require 2A 1B 0C 0D
- P2：capture 0A 1B 0C 1D，require 0A 0B 2C 1D
- P3：capture 0A 0B 1C 0D，require 1A 0B 0C 1D
- P4：capture 1A 1B 1C 1D，require 0A 1B 0C 0D
- Free Resource：1A 0B 0C 1D

We can first allocate free resource to P3. After P3 execution, the resource becomes: 1A 0B 1C 1D.

But it can never allocate resource for any processes among P1, P2 and P4.

Thus it is a unsafe state. The assumption failes and the allocation is not successful.

Thus the request cannot be granted.

### （3） Let’s assume P4’s request was granted anyway (regardless of the answer to question 2). If then the processes request additional resources as follows, is the system in a deadlock state? Why? [10 pts]

The system is not in a deadlock state.

After resource allocation, the resource condition is:


Then the resource condition is changed into:
- P1: capture 0A 2B 1C 0D，require 2A 1B 0C 0D
- P2：capture 0A 1B 0C 1D，require 0A 0B 1C 0D
- P3：capture 0A 0B 1C 0D，require 1A 0B 0C 0D
- P4：capture 1A 1B 1C 1D，require 0A 1B 0C 0D
- Free Resource：1A 0B 0C 1D

We first allocate 1A resource to P3. P3 can be executed normally and the free resource becomes:

1A 0B 1C 1D

Then allocate 1C resource to P2. P2 can be executed normally and the free resource becomes:

1A 1B 1C 2D

Then allocate 1B resource to P4. P4 can be executed normally and the free resource becomes:

2A 2B 2C 3D

Finally, P1 can be executed normally.

Therefore, the execution order is (P3, P2, P4, P1), and the system is in a safe mode.

## Q2. Dining philosophers problem

Two types of solutions:

**1. Use Sleep-based locks(pthread_mutex_lock)**

Explain your design idea: Use one `pthread_mutex_t` to lock the eating status, so that there is only 1 philosophers can eat the spaghetti.

The modified code screenshots:

![image](https://user-images.githubusercontent.com/64548919/167263734-f47e9742-4479-4196-9c81-cd9fc679d21b.png)

Running result screenshots:

![image](https://user-images.githubusercontent.com/64548919/167263769-42f5cb65-ceb3-490d-b5ef-3eaecd1eda7a.png)

**2. Use Spin-based locks**
