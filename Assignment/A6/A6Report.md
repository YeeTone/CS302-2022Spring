# Assignment6 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q0. CPU Scheduling

|                      | HRRN | FIFO/FCFS | RR | SJF | Priority |
|----------------------|------|-----------|----|-----|----------|
| 1                    | A    | A         | A  | A   | A        |
| 2                    | A    | A         | B  | A   | B        |
| 3                    | A    | A         | A  | A   | A        |
| 4                    | A    | A         | D  | A   | D        |
| 5                    | B    | B         | C  | B   | D        |
| 6                    | D    | D         | A  | D   | C        |
| 7                    | D    | D         | D  | D   | C        |
| 8                    | C    | C         | C  | C   | C        |
| 9                    | C    | C         | A  | C   | A        |
| 10                   | C    | C         | C  | C   | A        |
| Avg.Turn-around Time | 4.5  | 4.25      | 6  | 4.5 | 4.25     |

## Q1. Implement a syscall that can set the priority of current process

- Design idea:

read the source code and add some codes based on the existing.

- Modified code:

0. Release the annotations in `user/ex1.c`

1. Add code in `user/libs/ulib.h` and `user/libs/ulib.c`:

![image](https://user-images.githubusercontent.com/64548919/167280673-0dc1b00a-aa74-46ce-a448-04b4e7d9f1ab.png)

![image](https://user-images.githubusercontent.com/64548919/167280660-10fdf836-ab2d-427a-b5da-c7f5c7d65349.png)

2. Add code in `user/libs/syscall.h` and `user/libs/syscall.c`:

![image](https://user-images.githubusercontent.com/64548919/167280715-c40f3c0f-4fa7-40a5-af84-84b0acbdf062.png)

![image](https://user-images.githubusercontent.com/64548919/167280734-b38b9ada-301c-4f55-93fe-a4f1c52d9f8d.png)

3. Add #define in `libs/unistd.h`:

![image](https://user-images.githubusercontent.com/64548919/167280756-839ca107-09b8-4e22-9ac4-dcde6e8a5080.png)

4. Modify `user_main` in `kern/process/proc.c`:

![image](https://user-images.githubusercontent.com/64548919/167280780-3042a33c-b33d-4e54-88ff-a123488af324.png)

5. Modify `syscalls` in `kern/syscall/syscall.c`:

![image](https://user-images.githubusercontent.com/64548919/167288863-e2284c8b-5d17-4273-b1aa-de39e0239309.png)

- Running result:

![image](https://user-images.githubusercontent.com/64548919/167280647-9515aab0-c229-4e43-a7ab-cd9aba1f627e.png)


## Q2. Implement the RR scheduling algorithm based on priority

- Design idea: Use the priority to set the value of time_slice.

- Modified code:

0. Release the annotations in `user/ex2.c`

1. Modify the codes in `kern/schedule/default_sched.c`:

![image](https://user-images.githubusercontent.com/64548919/167281390-12659f3f-9579-4867-892e-103daaf42f26.png)

2. Modify `user_main` in `kern/process/proc.c`:

![image](https://user-images.githubusercontent.com/64548919/167281436-618cda9a-309f-49c1-8020-8370f0283d91.png)

- Running result:

![image](https://user-images.githubusercontent.com/64548919/167281472-7ca6a1a8-db63-4120-977d-8257bd94d90b.png)

## Q3. Preemptive process scheduling

- Design idea: Implement syscall in user and kern mode. Use loop to collect all the good values, then select the one with maximum value.

- Running sequence of processes: 6->5->3->7->4

- Modified code:

0. Release the annotations in `user/ex3.c`

1. Modify `user_main` in `kern/process/proc.c`:

![image](https://user-images.githubusercontent.com/64548919/167281616-bf7f6600-5c46-4e39-92ca-308794c90e04.png)

2. Unable the clock interrupt.

![image](https://user-images.githubusercontent.com/64548919/167288499-0981c551-f2da-485d-a125-6f2ade5fd2f4.png)

3. Add #define in `libs\unistd.h`:

![image](https://user-images.githubusercontent.com/64548919/167288538-cb98d07a-4845-4475-918a-e4a6c382d283.png)

4. Add `sys_setgood` in `kern/syscall/syscall.c`

![image](https://user-images.githubusercontent.com/64548919/167288584-1578c7af-aea9-428e-800f-be5484f85791.png)

5. Add `sys_setgood` in `user/libs/syscall.h` and `user/libs/syscall.c`

![image](https://user-images.githubusercontent.com/64548919/167288633-689cfc78-976b-4f46-8cfd-1f0f05b6b05a.png)

![image](https://user-images.githubusercontent.com/64548919/167288612-38b97a33-56e6-44a9-b2ef-cc7a6f9d1fc7.png)

6. Add `set_good` in `user/libs/ulib.h` and `user/libs/ulib.c`

![image](https://user-images.githubusercontent.com/64548919/167288688-6cff56f0-b1aa-4e85-8be2-bbcc072cd8da.png)

![image](https://user-images.githubusercontent.com/64548919/167288654-b8a5f2f8-a72a-422a-b72c-6a0a655c0cd4.png)

7. Modify `RR_pick_next` in `kern/schedule/default_sched.c`

![image](https://user-images.githubusercontent.com/64548919/167288923-ab186269-43bf-4cbd-9653-bb3059a0d848.png)

- Running result:

![image](https://user-images.githubusercontent.com/64548919/167288971-35da9b29-ab7c-4358-9df6-2cd4848b0100.png)
