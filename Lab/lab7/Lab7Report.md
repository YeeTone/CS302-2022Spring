# Week7 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1. Sv39 address translation

首先查看Sv39的虚拟地址和物理地址的结构，是一个三级页表的方案：

![image](https://user-images.githubusercontent.com/64548919/161210713-e5dabb14-427e-4315-8724-cac2b3596d77.png)

类似于Sv32，过程为：
1. satp.PPN给出一级页表的基址，VA\[38:30\]给出了一级页号，处理器读取地址为(stap.PPN * 4096 + VA\[38:30\] * 4)的页表项PTE1
2. 该PTE1包含二级页表的基址，VA\[29:21\]给出了二级页号，处理器读取地址为(PTE1.PPN * 4096 + VA\[29:21\] * 4)的页表项PTE2
3. 该PTE2包含二级页表的基址，VA\[20:12\]给出了二级页号，处理器读取地址为(PTE2.PPN * 4096 + VA\[20:12\] * 4)的页表项PTE3
4. PTE3的PPN字段和页内偏移（长度为12的offset）组成了最终结果，物理地址为(PTE3.PPN * 4096 + VS\[11:0\])

## Q2. Huge pages

如Q1所示，整体的偏移量表征为\[20:0\]，所以巨页的大小为2^21 Bytes，即为2MB。

## Q3. Page table calculation

4MB = 2^2 * 2^20 bytes = 2^22 bytes

Page size = 4KB = 2^12 bytes

因此需要 2^22 / 2^12 = 2^10 pages，需要一共有2^10个pages reference。

考虑二级页表的结构是10 | 10 | 12，因此需要访问二级页表中的2^10 / 2^10 = 1个块（Chunk，Page）。

一共三次访问，二级页表需要有三个相应的块指向，保存在三个二级页表中。

对于这三个块所在的二级页表，需要一个一级页表保存对其的指向。

因此一共需要1个一级页表和3个二级页表。

总共空间需要的空间：1 \* 2^10 * PTE_size + 3 \* 2^10 * PTE_size = 2^12  * PTE_size = 4KB * PTE_size
