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

可见在segmentation中，chunks的大小是可变的，因此也容易造成内存碎片。

#### Paging

以下部分来自chapter 18第一页：

![image](https://user-images.githubusercontent.com/64548919/161073960-4ce769ef-aee7-45e9-835f-f39d7fe7d1d3.png)

可见在paging中，chunks的大小的恒定的。

### Free space management

#### Segmentation

以下部分来自chapter 16第十页：

![image](https://user-images.githubusercontent.com/64548919/161075110-997810ae-b2f5-4678-a5ff-a4c8b0c42aba.png)

可见segmentation使用的management algorithm是free-list management algorithm，有很多经典的算法实现，如best-fit、worst-fit、first-fit等等。

#### Paging

以下部分来自chapter 18第六页：

![image](https://user-images.githubusercontent.com/64548919/161076037-76fb5c1d-59ac-410b-985c-7d05ff6e618e.png)

课件paging是使用page table做管理，用于记录进程逻辑页面与内存物理页面之间的对应关系。Page table有可能可以有多个等级。（因此带来了一个问题，就是page table的存储会消耗巨大空间）

### Context switch

#### Segmentation

以下部分来自chapter 16第八页：

![image](https://user-images.githubusercontent.com/64548919/161077672-0ec6fa9a-1831-49cd-ab6d-5d8403ceb132.png)

OS在上下文切换的时候需要操作：
- 保存segment寄存器中的值
- 设置virtual address space中的值
- 启动相关即将切换到的进程

#### Paging

关于Paging与Context switch，在chapter 18中暂未找到对应说明。

但张殷乾老师的ppt中有相关内容：

![image](https://user-images.githubusercontent.com/64548919/161083741-98e4468a-7955-4f08-884a-ba7600f86f04.png)

![image](https://user-images.githubusercontent.com/64548919/161084073-056fcc2e-3834-480b-a430-f8e6582ee63f.png)


可见在context switch中，代价是比较低。需要修改对page table的指针，也需要修改TLB对应内容，处理方式有两种：
- 完全刷新TLB，缺陷是开销巨大
- 增加硬件支持，添加对于进程ID的映射，以缓存不同进程空间的地址映射

### Fragmentation

#### Segmentation

以下内容可见于chapter 16第九页：

![image](https://user-images.githubusercontent.com/64548919/161085452-29dc0e52-5c44-49a1-b3ca-4d53810bd377.png)

由于segmentation的空间分配中，块的大小可变，因此不会造成内存碎片，而容易造成外存碎片（后续虽然有空余空间，但没有一片足够连续的空间可供分配）。

#### Paging

以下内容可见于chapter 18第十二页：

![image](https://user-images.githubusercontent.com/64548919/161086273-5ab8441c-b9ed-4176-945f-7bfc20f8e127.png)

由于分配的块内存的大小恒定，因此paging不会造成外存碎片，但会造成内存碎片（内存分配了，但是没有被使用）。

## Q3. Page Table Design
这里考虑使用三级页表，将剩下的33bits均分为三个11bits，总体结构如下所示：

![image](https://user-images.githubusercontent.com/64548919/161102845-da548c4e-6436-4d80-bb57-8f9d45977223.png)

这里设计的原因如下：

由于page size是8kb（2^13 bytes），因此offset的长度是13bits，剩余46 - 13 = 33bits。

每个page table entry的大小是4 bytes，那么一个page就可以容纳2^11个entry，需要11个二进制数字做对应。

因此正好可以将33等分为3个11bits的entry，变为三级页表。

## Q4. Page Calculation

### Q4-1
Page Size: 2^12 = 4096, 4Kb

考虑到这是一级页表，那么就至多会有2^20个页表项。每个页表项占用空间4 bytes，因此至多占用2^20 * 4 = 2^22 bytes = 4MB

### Q4-2
（1）0xC302C302 = 1100001100 0000101100 001100000010

Offset: 0x302 = 770

Page number: 1100001100 = 780

（2）0xEC6666AB = 1110110001 1001100110 011010101011

Offset: 0x6AB = 1707

Page number: 1001100110 = 614

## Q5. Merging free blocks

Codes in the `static void default_free_pages(struct Page *base, size_t n)`:

![image](https://user-images.githubusercontent.com/64548919/161117988-0cc9d59e-932e-400e-a264-31b25c47714d.png)

Checking results:

![image](https://user-images.githubusercontent.com/64548919/161118348-34096206-dcd3-4cc2-a718-f2f6ea45302a.png)

## Q6. Bestfit Implementation

Codes in the `best_fit_pmm.c`:

![image](https://user-images.githubusercontent.com/64548919/161126313-1fd45d00-d4ae-4e00-a6b1-54c41a289a4f.png)


Checking results:

![image](https://user-images.githubusercontent.com/64548919/161125586-b10f95ea-f3ab-486b-95e7-eb8b0c0bd85d.png)
