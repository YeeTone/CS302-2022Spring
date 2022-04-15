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

This is the draft, showing the replacement process.

![image](https://user-images.githubusercontent.com/64548919/163595324-9a474ca9-1c7d-41cc-bc8e-a187a1ec697f.png)


## Q3 Clock Algorithm

Code screenshot:

![image](https://user-images.githubusercontent.com/64548919/163594183-3e484bad-af37-49ce-9ba1-177238e77d81.png)

Part of `swap.c`:

![image](https://user-images.githubusercontent.com/64548919/163594314-fc2750db-0f9f-494a-8ad6-988d716a04ad.png)

Commands under the directory `./week8_exe`:

```
make clean
make qemu
```

Running result:

![image](https://user-images.githubusercontent.com/64548919/163594539-2eeb8a0d-59e9-4229-8558-b07dc8f23141.png)


## Q4 LRU Algorithm

Code screenshot:

![image](https://user-images.githubusercontent.com/64548919/163594765-cb7f8956-84d1-43e9-b230-3ccccc33103b.png)

Part pf `swap.c`:

![image](https://user-images.githubusercontent.com/64548919/163595073-edd6d65b-7fe7-4b83-83da-aa5600e41e71.png)


Commands under the directory `./week8_exe`:

```
make clean
make qemu
```

Running result:

![image](https://user-images.githubusercontent.com/64548919/163595119-67c5c436-baa0-4927-8fa3-ef8a3af23dfc.png)
