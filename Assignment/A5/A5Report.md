# Assignment5 Report
Name：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

SID：11910104

Lab：Friday5-6节

Lab Teacher：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

Lab SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 Page Fault

1. OS swap the page into memory by page table. 
OS looks in the PTE to find the address, and issues the request to disk to fetch the page into memory;
2. Disk I/O to get the page and the process is blocked;
3. OS update the page table(may depend on different replacement policy if the memory is full);
4. Restart the process and find the translation in the TLB to get the data;

Relevant screenshots in this chapter(Page 4 and Page 5):

![image](https://user-images.githubusercontent.com/64548919/163381001-72a31691-f8f0-42e1-8042-3456a573c737.png)

![image](https://user-images.githubusercontent.com/64548919/163381032-5808086b-5727-4d50-b5e5-fb8963ab3d4f.png)

## Q2 Replacement Policy

Number of Page Faults:
- OPT: 8
- LRU: 8
- FIFO: 10
