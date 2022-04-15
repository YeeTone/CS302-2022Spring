# Week8 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 `do_fork`
do_fork函数自身的功能：创建当前内核的线程的一个副本，完全复制一份上下文，代码和数据，并为新线程分配资源。

调用函数的功能：
- alloc_proc：分配并初始化进程的控制块
- setup_kstack：分配并初始化内核栈
- copy_mm: 复制或共享内存管理（本次实验中没有起作用）
- copy_thread: 设置进程的中断帧和上下文
- list_add: 将设置好的进程加入链表
- wakeup_proc：设置新进程为就绪态
- put_kstack：setup_kstack内存不足时，重设内核栈
- kfree：清理释放创建失败的进程的资源

调用流程：
```
当前进程数满了 -> 直接返回 -E_NO_FREE_PROC
alloc_proc()失败了 -> 直接返回 -E_NO_MEM
setup_kstack(proc)为-E_NO_MEM -> 释放proc资源，然后返回-E_NO_MEM
复制内存内容
设置进程的中断帧和上下文
将新进程加入链表
设置为就绪态
更新进程数
返回新进程id
```
> reference: https://zhuanlan.zhihu.com/p/263007381


## Q2 `schedule`

schedule函数自身的功能：实现CPU的调度

调用函数的相关功能：
- local_intr_save：关闭中断功能，避免因中断引起并发问题
- list_next：拿到链表的下一个节点的指针
- le2proc：翻译成进程，以供后续RUNNABLE状态的检查
- proc_run：上下文切换，使得next获得CPU资源
- local_intr_restore：恢复系统中断功能

调用流程：
```
local_intr_save关闭系统中断

设置current进程状态为不需要等待

通过list_next遍历和le2proc翻译，尝试寻找处于PROC_RUNNABLE的线程

如果没有找到：
    next <- idleproc
更新next，并且通过proc_run分配CPU资源给next

local_intr_restore恢复系统中断
```
