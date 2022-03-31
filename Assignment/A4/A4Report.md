# Assignment4 Report
Name：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

SID：11910104

Lab：Friday5-6节

Lab Teacher：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

Lab SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1. CPU hardware and OS cooperation
- Hardware provides two CPU modes and their switching：kernel mode and user mode. OS is in kernel mode, and user application is in the user mode.

The following figure is from page 8 of Chapter 15:

![image](https://user-images.githubusercontent.com/64548919/161127878-310f2244-dccc-43e5-b522-a094a640ba40.png)

- Hardware provides base and bounds registers and related memory management mechanisms to allow OS to do context switching.

The following figure is from page 8 of Chapter 15:

![image](https://user-images.githubusercontent.com/64548919/161128038-c5a27665-5071-4cb1-a73e-ceecf40df44a.png)

- Hardware generates exceptions and gives them to the OS for related processing.

The following figure is from page 9 of Chapter 15:

![image](https://user-images.githubusercontent.com/64548919/161128504-9657132e-b376-44b3-b585-bd85d4d1744e.png)


## Q2. Comparing segmentation and paging

### Size of chunks

#### Segmentation

The following figure is from page 10 of Chapter 16:

![image](https://user-images.githubusercontent.com/64548919/161073725-6f4f181f-bd45-44c9-a1b7-6ccf73ca5ea2.png)

It can be seen that in segmentation, the size of chunks is variable. Thus it is also easy to cause internal fragmentation.

#### Paging

The following figure is from page 1 of Chapter 18:

![image](https://user-images.githubusercontent.com/64548919/161073960-4ce769ef-aee7-45e9-835f-f39d7fe7d1d3.png)

It can be seen that in paging, the size of chunks is fixed.

### Free space management

#### Segmentation

The following figure is from page 10 of Chapter 16:

![image](https://user-images.githubusercontent.com/64548919/161075110-997810ae-b2f5-4678-a5ff-a4c8b0c42aba.png)

It can be seen that the management algorithm used in segmentation is free-list management algorithm, which is implemented by many classical algorithms, such as best-fit, worst-fit, first-fit and so on.

#### Paging

The following figure is from page 6 of Chapter 18:

![image](https://user-images.githubusercontent.com/64548919/161076037-76fb5c1d-59ac-410b-985c-7d05ff6e618e.png)

It can be seen that paging is managed by page tables, which are used to record the corresponding relationship between process logical pages and memory physical pages. Page table may have multiple levels. (This brings a problem, that is, the storage of page table will consume huge space)

### Context switch

#### Segmentation

The following figure is from page 8 of Chapter 16:

![image](https://user-images.githubusercontent.com/64548919/161077672-0ec6fa9a-1831-49cd-ab6d-5d8403ceb132.png)

OS needs to do:
- save segment registers' value
- set values in virtual address space
- start the process to be switched

#### Paging
For paging and context switch, no corresponding description is found in Chapter 18.

But there are some relevant content in the slides of Prof.Yinqian ZHANG:

![image](https://user-images.githubusercontent.com/64548919/161083741-98e4468a-7955-4f08-884a-ba7600f86f04.png)

![image](https://user-images.githubusercontent.com/64548919/161084073-056fcc2e-3834-480b-a430-f8e6582ee63f.png)

It can be seen that in context switch, the cost is relatively low. 
It need to modify the pointer to page table and the corresponding content of TLB. 
There are two processing methods:

- Completely refreshing TLB. The defect is the huge overhead.

- Add the address of the process in different cache space to support the mapping of different hardware processes.

### Fragmentation

#### Segmentation

The following figure is from page 9 of Chapter 16:

![image](https://user-images.githubusercontent.com/64548919/161085452-29dc0e52-5c44-49a1-b3ca-4d53810bd377.png)

In the space allocation of segmentation, the size of the block is variable, so it will not cause memory fragmentation, but easy to cause external memory fragmentation. (Although there is free space in the future, there is not enough continuous space for allocation)

#### Paging

The following figure is from page 12 of Chapter 18:

![image](https://user-images.githubusercontent.com/64548919/161086273-5ab8441c-b9ed-4176-945f-7bfc20f8e127.png)

Since the size of allocated block memory is constant, paging will not cause external memory fragmentation, but will cause internal fragmentation (memory is allocated but not used).

## Q3. Page Table Design
Consider using 3-level page tables and dividing 33 bits into 3\*11 bits, as the following figure shows:

![image](https://user-images.githubusercontent.com/64548919/161102845-da548c4e-6436-4d80-bb57-8f9d45977223.png)

Reason for the design:

page size = 8kb(2^13 bytes) -> offset.length = 13 bits -> rest.length = 46 - 13 = 33bits。

The size of each page table entry is 4 bytes, so a page can accommodate 2^11 entries, which requires 11 binary digits.

Therefore, 33 can be equally divided into three 11 bits entries to become a 3-level page table.

## Q4. Page Calculation

### Q4-1
Page Size: 2^12 = 4096, 4Kb

Considering that this is a level 1 page table, there will be at most 2 ^ 20 page table entries. Each page table item occupies 4 bytes of space, so at most 2 ^ 20 * 4 = 2 ^ 22 bytes = 4MB

### Q4-2
(1)0xC302C302 = 1100001100 0000101100 001100000010

Offset: 0x302 = 770

Page number: 1100001100 = 780

(2)0xEC6666AB = 1110110001 1001100110 011010101011

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
