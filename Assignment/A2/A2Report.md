# Assignment2 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 qemu指令参数
优先考虑使用```qemu-system-riscv64 -help```命令查看帮助文档：

![image](https://user-images.githubusercontent.com/64548919/156988584-02b4e8e2-35e4-4327-832a-b44c9a37f24e.png)

### -machine virt
从文档中，可见该参数的功能是选取仿真所用的机器：

![image](https://user-images.githubusercontent.com/64548919/156988882-641a7456-0673-4226-b272-2d75bc04bae0.png)

然后考虑使用```qemu-system-riscv64 -machine help```获取可用的机器列表，可以发现```virt```：

![image](https://user-images.githubusercontent.com/64548919/156989010-26f803c3-6c85-4538-b9ca-c10b260f7717.png)

因此该参数的意义为选取仿真所用的机器为：RISC-V VirtIO board

### -nographic

从文档中，可见该参数的功能是禁用图形输出并将串行I/O重定向到控制台：

![image](https://user-images.githubusercontent.com/64548919/156989615-1c8f58ae-bb6c-43d3-9f68-426259d874ad.png)

### -bios default

从文档中，可见该参数的功能是设置```BIOS```的文件名为```default```

![image](https://user-images.githubusercontent.com/64548919/156989952-f8459a73-b353-44bd-8f4d-13cbe3ed051c.png)

### -device loader,file=bin/ucore.bin,addr=0x80200000
先考虑在文档中找到-device参数对应的功能：

![image](https://user-images.githubusercontent.com/64548919/156990435-ce32677a-1da0-4a49-9ad5-52a77dac442b.png)

然后考虑输入```qemu-system-riscv64 -device loader,help```查询名为loader的driver可用的参数列表：

![image](https://user-images.githubusercontent.com/64548919/156990837-c06bf909-cfe3-4c16-b79a-6be209aa3cd6.png)

