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

## Q3. Page Fault

在进程CPU访问虚拟地址时，找不到对应的物理内存的时候出发缺页中断。主要有两种可能：
- 页表中不存在虚拟地址对应的PTE（Page Table Entry），属于下列两种之一
  - 虚拟地址无效
  - 虚拟地址有效，但没有分配物理内存页与建立映射关系
- 现有的权限不能操作对应的PTE

## Q4. Major Page Fault

major page fault也称为hard page fault, 指需要访问的内存不在虚拟地址空间，也不在物理内存中，需要从慢速设备载入。处理方法是需要重新从外部的慢速设备中载入页的相关信息。

主要是在`kern/mm/vmm.c`文件中：

![image](https://user-images.githubusercontent.com/64548919/162393211-8638ba4e-2e97-429a-a4a1-c50823dc55a7.png)


## Q5. swap_in & swap_out

Swap只会发生在数据不在RAM（Random Access Memory）中的情况。
- Swap in：将硬盘中的数据放入主存或者RAM。时机是只要内存仍有空闲空间的时候，就会发生Swap in；或者在空间满了，Swap out清理出一片空间后，会再通过Swap in换进来
- Swap out：将RAM中数据放入硬盘，主要应用于内存空间满了的情况，需要选择一些不太可能经常访问的数据（这取决于具体算法）清理出新空间给新数据高速访问。
