# Week8 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1. mm_struct
一个进程有一个mm_struct。

mm_struct是内存描述符，描述一个进程的虚拟地址空间，包含装入的可执行映像信息以及进程的页目录指针pgd。

> reference: https://blog.csdn.net/lf_2016/article/details/54346121?ref=myread

## Q2. vma_struct

vma_struct结构体描述一段连续的虚拟地址，从 vm_start 到 vm_end，描述了虚拟地址空间的一个区间(简称虚拟区)。

> reference: https://blog.csdn.net/lf_2016/article/details/54346121?ref=myread
