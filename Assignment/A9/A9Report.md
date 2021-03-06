# Assignment9 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## 1. Disk scheduling
(1) READ/WRITE data time =  Seek Time + Rotational Latency + Transfer Time

(2) 

a. Track Access Sequence:
- FIFO: 70 => 30 => 90 => 120 => 60 => 20
- SSTF: 90 => 70 => 60 => 30 => 20 => 120
- SCAN: 120 => 90 => 70 => 60 => 30 => 20
- CSCAN: 120 => 20 => 30 => 60 => 70 => 90

b. Time Calculation

For the seek time, first calculate their tracks:

- FIFO: (100-70) + (70-30) + (90-30) + (120-90) + (120-60) + (60-20) = 260
- SSTF: (100-90) + (90-70) + (70-60) + (60-30) + (30-20) + (120-20) = 180
- SCAN: (120-100) + (199-120) + (199-90) + (90-70) + (70-60) + (60-30) + (30-20) = 278
- CSCAN: (120-100) + (199-120) + (199-0) + (20-0) + (30-20) + (60-30) + (70-60) + (90-70) = 388

Thus time is:
- FIFO: 260ms
- SSTF: 180ms
- SCAN: 278ms
- CSCAN: 388ms

For FIFO\SSTF\SCAN\CSCAN algorithm, their rotational latency is the same.

12000r/min => 200r/s => 0.2r/ms => 5ms/r

Since it is randomly distributed access, we treat it as half round: 2.5ms

Since 6 accesses, total time = 2.5ms\*6 = 15ms

The question does not tell us the transfer time, thus we omitted.

Total Time: 
- FIFO: 260+15=275ms
- SSTF: 180+15=195ms
- SCAN: 278+15=293ms
- CSCAN: 388+15=403ms


## 2. Simple File System
Consider adding one statement in `tools/mksfs.c`:

![image](https://user-images.githubusercontent.com/64548919/172047370-e504f1a7-17f0-4562-9931-c3a54f53d20a.png)

And the partial output of `make qemu` is:

![image](https://user-images.githubusercontent.com/64548919/172047327-966ce84c-b253-457c-99a1-af14024d3ebe.png)

Thus we draw the diagram according to the running result:

![image](https://user-images.githubusercontent.com/64548919/172047576-f5e18f32-0776-48ee-ab04-d9c5e32d6870.png)

Since 25-116 are free, the 25-116 bits are 1.

Here is a brief explanation:

![943D19122D2C2ED57C09A072C90FBF55](https://user-images.githubusercontent.com/64548919/172047782-f4cb9db3-5d48-4cb2-874e-203c6de0e14d.jpg)

