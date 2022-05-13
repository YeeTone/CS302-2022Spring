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

