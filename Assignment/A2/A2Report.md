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
```.text```段即为代码段，里面的```*(.text.kern_entry .text .stub .text.* .gnu.linkonce.t.*)```会指示将工程中所有目标文件的```.text.kern_entry```，```.text```， ```.stub```，```.text.*```，```.gnu.linkonce.t.*```都链接到FLASH中。其中```*```是通配符，可以匹配符合前缀的任意文件。```.text```表示代码段的起始地址。

> Reference

> https://www.cnblogs.com/dylancao/p/9228885.html

```
PROVIDE(etext = .); /* Define the 'etext' symbol to this value */
```
```provide```关键字用于定义一个符号，如```etext```。如果程序中再次定义了该符号，则使用程序中定义的，否则则使用链接器脚本中的定义。这里是将```.```所代表的的地址值赋值给```etext```。

> Reference

> https://blog.csdn.net/x13015851932/article/details/48253695

```
.rodata : {
   *(.rodata .rodata.* .gnu.linkonce.r.*)
}
```

```.rodata```字段用于定义**read-only data**，用于保存只读数据。里面的```*(.rodata .rodata.* .gnu.linkonce.r.*)```会指示将工程中所有目标文件的```.rodata```，```.rodata.*```， ```.gnu.linkonce.r.*```文件都链接到FLASH中。其中```*```是通配符，可以匹配符合前缀的任意文件。

```
/* Adjust the address for the data segment to the next page */
    . = ALIGN(0x1000);
```

如之前所述，这条语句的作用是重设当前段的地址```.```。其中```ALIGN(0x1000)```表示按照指定的边界进行排列，里面的参数必须是2的倍数。

```
/* The data segment */
.data : {
   *(.data)
   *(.data.*)
}
```

这里前一句是注释，编译器无视之。后面是用于定义```data```字段（数据段），里面会指示将工程中所有目标文件的```.data```，```.data.*```文件都链接到FLASH中。其中要注意：```data```字段是用于保存初始化的全局数据。```.data```是一个地址，表示代码段的结束地址，也是数据段的起始地址。

```
.sdata : {
   *(.sdata)
   *(.sdata.*)
}
```

这里是用于定义```sdata```字段，它包含初始化的全局小数据，里面会指示将工程中所有目标文件的```.sdata```，```.sdata.*```文件都链接到FLASH中。

```
PROVIDE(edata = .);
```

如之前所介绍，这里是定义```edata```符号，并将```.```所代表的地址值赋值给```edata```。```edata```是```bss```段的开始地址。

```
.bss : {
   *(.bss)
   *(.bss.*)
   *(.sbss*)
}
```

这里是用于定义```bss```字段，它包含未初始化的全局数据，里面会指示将工程中所有目标文件的```.bss```，```.bss.*```，```.sbss*```文件都链接到FLASH中。```.bss```是一个地址，表示数据段的结束地址和BSS段的起始地址。

> Reference

> https://www.wenjiangs.com/doc/b5owlkja

```
PROVIDE(end = .);
```

如之前所介绍，这里是定义```end```符号，并将```.```所代表的地址值赋值给```end```。```end```表示BSS段的结束地址。

```
/DISCARD/ : {
   *(.eh_frame .note.GNU-stack)
}
```

```/DISCARD/```关键字的作用是舍弃指定段，不会出现在输出文件中。在这里是舍弃掉```.eh_frame```和```.note.GNU-stack````段。

> Reference

> https://www.iteye.com/blog/yefzhu-1561933

## Q3 memset(edata, 0, end - edata); 的参数及语句作用

注意Q2中的代码语句：
```
PROVIDE(edata = .);

.bss : {
   *(.bss)
   *(.bss.*)
   *(.sbss*)
}

PROVIDE(end = .);
```

```edata```数据段是bss段的开始，而```end```数据段是bss段的结束。又考虑bss段的作用是存放初始化为0的可读写数据，因此这句语句的作用就是将bss段的数据内容全部初始化为0。

## Q4 ecall指令的调度流程
根据lab3，我们可知打印字符是在```/kern/init/init.c```文件中调用```cputs```以实现的：

![image](https://user-images.githubusercontent.com/64548919/157353638-32ee9eb2-2f67-416a-92a6-c54774eafef6.png)

然后考虑顺藤摸瓜，找到```/kern/libs/stdio.c```中对```cputs```的定义，发现它调用了同文件中的```cputch```方法：

![image](https://user-images.githubusercontent.com/64548919/157353824-08945757-fd6e-4cc0-a7ae-4810b55e39bd.png)

![image](https://user-images.githubusercontent.com/64548919/157353873-57c731bb-49c9-43a0-96ef-cdc1cc43e6ad.png)

然后发现```cputch```方法中调用了```cons_putc```方法，这是一个定义在```kern/driver/console.c```的方法：

![image](https://user-images.githubusercontent.com/64548919/157354249-ff983150-6ca9-4364-82fa-7b85b2c84527.png)

这里面调用的```sbi_console_putchar```方法实现在```libs/sbi.c```文件中，通过对其中的方法调用的分析，即可寻找到ecall指令的调用位置，这里面是通过内联汇编实现的调用：

![image](https://user-images.githubusercontent.com/64548919/157354436-79009c1c-cce6-4b42-bd29-927351bc29f9.png)

