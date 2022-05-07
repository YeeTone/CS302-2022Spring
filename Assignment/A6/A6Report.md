# Assignment6 Report
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

Therefore, the execution order is (P3, P2, P4, P1).

### （2） If P4 requests (0,0,1,1), please run the Banker’s algorithm to determine if the request should be granted.
