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

The modified code screenshot:

![image](https://user-images.githubusercontent.com/64548919/168101934-61efaaa7-1abb-42b3-90e1-5bca5a1221f6.png)

Running result screenshot:

![image](https://user-images.githubusercontent.com/64548919/167263769-42f5cb65-ceb3-490d-b5ef-3eaecd1eda7a.png)

**2. Use ReentrantLock**

Explain your design idea:

Use 2 locks: 1 mutex lock and 1 conditional lock. For each eating operation, we need to check the forks on the left and right, and waiting until the forks are released. And we use 1 integer array to represent the forks using status.

The modified code screenshots:

![image](https://user-images.githubusercontent.com/64548919/168101330-d8568d31-fc48-44c5-aedb-c7653c3c9766.png)

![image](https://user-images.githubusercontent.com/64548919/168101404-92b8d2ee-b4d1-41c3-b9b9-66e67e964b6b.png)

Running screenshot:

![image](https://user-images.githubusercontent.com/64548919/168101760-95a73d23-311d-48c1-9109-abb6c2ee412c.png)

> Reference: https://leetcode.cn/problems/the-dining-philosophers/solution/zhe-xue-jia-jin-can-by-skyshine94-7blq/

## Q3. The too much milk problem

Explain your design idea:

Use 2 semaphores to solve this problem. One to handle the milk buying threads(i.e. dad, mom and grandfather) and another to handle the milk drinking thread(i.e. son).

The code screenshots:

![image](https://user-images.githubusercontent.com/64548919/168226668-3cbc9ab0-d899-4371-9ec6-3a3dd2c54c4d.png)

![image](https://user-images.githubusercontent.com/64548919/168226708-82cb12e6-ad2e-4eb9-a62b-d28fe61258ee.png)

![image](https://user-images.githubusercontent.com/64548919/168226771-c25b54f8-6c9f-4d7a-b068-b1d89d4e838c.png)

![image](https://user-images.githubusercontent.com/64548919/168226804-0cf53a89-e1ff-4e38-bc09-8c3d7a734ebc.png)

![image](https://user-images.githubusercontent.com/64548919/168226828-1e196549-ed14-4480-a522-427b20d47311.png)

![image](https://user-images.githubusercontent.com/64548919/168226862-80f32599-d738-4356-879c-5b8429c2f992.png)

![image](https://user-images.githubusercontent.com/64548919/168226891-e2a00a53-6de6-432c-89dd-ecdda0e09eac.png)

Running Result:

![image](https://user-images.githubusercontent.com/64548919/168227286-dab17cfe-ac74-4b8a-a58f-0c13fa736b67.png)

