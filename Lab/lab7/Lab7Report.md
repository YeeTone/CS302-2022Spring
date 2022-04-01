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
