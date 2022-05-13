# Week13 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1. local_intr_save(intr_flag);

如课件中代码所示：
```C
...... 
local_intr_save(intr_flag); 
{ 
    临界区代码 
}
local_intr_restore(intr_flag); 
......
```

可见```local_intr_save(intr_flag);```是和```local_intr_restore(intr_flag); ```一起避免在进程切换过程中处理中断。

## Q2. Philosopher problem

(1) 可避免死锁。

原因：可以通过`sem_init(&s[i], 1);`确保只有1个哲学家能够拿起筷子，从而将多个线程的执行退化为单线程情况，以避免死锁。

当唯一执行的哲学家将锁释放后，剩余的哲学家尝试同时竞争锁，拿到锁的哲学家分为两种情况：

- 与释放锁的哲学家相邻：这样就会进入等待状态，直到哲学家用餐完毕才继续执行
- 与释放锁的哲学家不相邻：无需等待，直接释放锁即可。

（2）

代码截图：

![image](https://user-images.githubusercontent.com/64548919/168234142-0c6153e8-97d7-416a-bb58-c4e381ca3e65.png)

![image](https://user-images.githubusercontent.com/64548919/168234180-34d636a3-bf26-498e-b2b2-a949ef24ee64.png)

运行截图：

![image](https://user-images.githubusercontent.com/64548919/168234046-973dce4a-1537-4849-93ff-ddad1973dd82.png)

