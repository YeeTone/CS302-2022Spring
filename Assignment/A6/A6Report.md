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

0. Release the comments in `user/ex1.c`

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

5. Modify `syscalls` in `kern/syscall.c`:

![image](https://user-images.githubusercontent.com/64548919/167280791-34b350e8-f4a4-4092-9f32-a138619da5b8.png)

- Running result:

![image](https://user-images.githubusercontent.com/64548919/167280647-9515aab0-c229-4e43-a7ab-cd9aba1f627e.png)


## Q2. Implement the RR scheduling algorithm based on priority

- Design idea: Use the priority to set the value of time_slice.

- Modified code:

0. Release the comments in `user/ex2.c`

1. Modify the codes in `kern/schedule/default_sched.c`:

![image](https://user-images.githubusercontent.com/64548919/167281390-12659f3f-9579-4867-892e-103daaf42f26.png)

2. Modify `user_main` in `kern/process/proc.c`:

![image](https://user-images.githubusercontent.com/64548919/167281436-618cda9a-309f-49c1-8020-8370f0283d91.png)

- Running result:

![image](https://user-images.githubusercontent.com/64548919/167281472-7ca6a1a8-db63-4120-977d-8257bd94d90b.png)

## Q3. Preemptive process scheduling

- Design idea:

- Modified code:

0. Release the comments in `user/ex3.c`

1. Modify `user_main` in `kern/process/proc.c`:

![image](https://user-images.githubusercontent.com/64548919/167281616-bf7f6600-5c46-4e39-92ca-308794c90e04.png)

