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

## Q2 kernel.ld文件中每一行的作用

```
/* Simple linker script for the ucore kernel.
   See the GNU ld 'info' manual ("info ld") to learn the syntax. */
```

这一段是简单的注释，编译器会无视该部分。

```
OUTPUT_ARCH(riscv)
```

这句话表示设置输出文件对应的处理器架构为RiscV。

> Reference

> https://www.cnblogs.com/ICkeeper/p/15514775.html

```
ENTRY(kern_entry)
```

这句话表示Entry Point **(EP)**，是BIOS移动完内核后，直接跳转的地址，是程序的入口。而kern_entry是体系相关的汇编语言实现的。

> Reference

> https://blog.csdn.net/wangyao199252/article/details/74938761

> https://sourceware.org/binutils/docs/ld/Entry-Point.html#Entry-Point

```
BASE_ADDRESS = 0x80200000;
```

表示基地址，是低地址，链接脚本会从基地址放置.text, .rodata等等数据段。


```
SECTIONS
{
   ...
}
```
这部分是链接脚本的整体，是用于描述整个内存布局，其内有输入段，输出段等等数据段。


```
. = BASE_ADDRESS;
```
这句话表示当前地址，让设置的地址从低地址往高地址做段的放置操作。这条语句的作用是记录当前段的地址```.```.

```
.text : {
    *(.text.kern_entry .text .stub .text.* .gnu.linkonce.t.*)
}
```
```.text```段即为代码段，里面的```*(.text.kern_entry .text .stub .text.* .gnu.linkonce.t.*)```会指示将工程中所有目标文件的```.text.kern_entry```，```.text```， ```.stub```，```.text.*```，```.gnu.linkonce.t.*```都链接到FLASH中
