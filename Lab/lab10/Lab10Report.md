# Week10 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 S->U
## Q2 用户进程调用系统调用
用户进程：用户态运行

系统进程：内核态运行

调用：
- CPU的特权级切换，由U态进入S态
- 封装对应的系统调用函数，作为用户程序调用的接口，供用户调用
- 系统调用函数中，通过内联汇编进行ecall环境调用
## Q3 模式切换
## Q4 僵尸进程
僵尸进程的形成：一个进程结束，但是父进程没有等待它，那么此时子进程的相关信息就保存在系统进程表中，就形成了僵尸进程。
## Q5 load_icode()
load_icode()是在do_execve()函数中被调用，主要功能是将新的程序加载到当前进程，为用户进程分配新的资源，比如说MM，页表，用户栈等等。
