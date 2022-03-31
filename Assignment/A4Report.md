# Assignment4 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1. CPU hardware and OS cooperation

首先分析出CPU hardware和OS的相关职能：
- CPU hardware: 
  - 动态地址分配
  - 虚拟地址和物理地址的翻译
  - 内存的管理
  - 为OS提供特殊指令，改变base和bounds寄存器
  - 提供CPU modes
  - 产生exception

- OS:
  - 进程创建时，找到其地址空间对应的内存区域
  - 进程结束时，释放内存并重新调配给其他的进程，或者给OS本身
  - 上下文切换时，修改base和bounds寄存器，并且能够现场恢复
  - 处理CPU hardware产生的exception

## Q2. Comparing segmentation and paging

### Size of chunks

#### Segmentation

以下部分来自chapter 16第十页：

![image](https://user-images.githubusercontent.com/64548919/161073725-6f4f181f-bd45-44c9-a1b7-6ccf73ca5ea2.png)

可见在segmentation中，chunks的大小是可变的。

#### Paging

以下部分来自chapter 18第一页：

![image](https://user-images.githubusercontent.com/64548919/161073960-4ce769ef-aee7-45e9-835f-f39d7fe7d1d3.png)

可见在paging中，chunks的大小的恒定的。


## Q3.

## Q4.

## Q5.
