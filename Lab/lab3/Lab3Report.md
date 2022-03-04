# Week3 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1: 最小化内核的启动过程
- 下载代码并解压到相关目录，然后切换目录到lab3下

![image](https://user-images.githubusercontent.com/64548919/156711083-fb11b8f7-f395-4aad-8b73-3097a97d2181.png)

- 在命令行使用```make```命令，生成模拟硬盘

![image](https://user-images.githubusercontent.com/64548919/156711214-dae10e11-ad7f-4342-ae08-912386c2b8e9.png)

- 使用```make qemu```命令，启动最小化内核

![image](https://user-images.githubusercontent.com/64548919/156711306-a9958eb8-e4bd-48d1-ae20-f34437548b7c.png)

## Q2: elf和bin文件的区别

- ELF: executable and link format, 包含符号表，汇编，调试信息等等，可以指定程序每个section的内存布局，不能直接运行，需要完整的操作系统来解析运行。OpenSBI不能直接运行elf文件。
- BIN：raw binary，只包含机器码，是将ELF文件中的代码段，数据段，以及其他自定义段抽取出来形成的一个内存的镜像。OpenSBI可以直接运行。

> Reference
> https://blog.csdn.net/chengf223/article/details/121639975
> http://blog.chinaunix.net/uid-25100840-id-2853463.html
> https://blog.csdn.net/soitis1121/article/details/8284425
> https://cloud.tencent.com/developer/ask/109491

## Q3: 链接脚本的作用
- 链接器：将输入文件链接成输出文件，可以将各种代码和数据片段收集起来组合成单一文件。链接过程可能发生在编译，内存加载，程序执行的时候。
- 链接脚本：描述如何将输入文件的section，映射到输出文件的section，并规定这些section的内存布局。链接脚本用于描述链接器处理目标文件和库文件的方式，如：
  - 合并各个目标文件的段
  - 重定位各个段的起始地址
  - 重定位各个符号的最终地址

> Reference
> https://blog.csdn.net/ehuangdan5864/article/details/107744789
> https://www.yisu.com/zixun/5633.html

## Q4: init.c打印特定字符串

- 打开```kern/init/init.c```文件，并添加打印```SUSTech OS```的相关语句。

![image](https://user-images.githubusercontent.com/64548919/156715182-c1d7a0f8-214c-42b2-af45-827278759fff.png)

- 回到lab3目录下，使用```make clean```命令做清除操作。

- 再参考```Q1```的流程步骤，即可打印出```SUSTech OS```。

![image](https://user-images.githubusercontent.com/64548919/156715635-6183d481-9bbc-4a0b-b5b5-39186746c907.png)

## Q5: 参考cputs()函数实现double_puts()函数

- 打开```lab3/kern/libs```目录下的```stdio.c```，添加```double_puts()```函数的具体实现。

![image](https://user-images.githubusercontent.com/64548919/156718277-e8036f75-a5dc-4743-b01b-9b72af66a5bf.png)

- 打开```lab3/libs```目录下的```stdio.c```，添加```double_puts()```函数的声明。

![image](https://user-images.githubusercontent.com/64548919/156718443-cd345969-6952-4a99-9d78-9ee3f7665c7d.png)

- 打开```kern/init/init.c```文件，并添加调用```double_puts()```函数以打印```SSUUSSTTeecchh```和```IILLOOVVEEOOSS```的相关语句。

![image](https://user-images.githubusercontent.com/64548919/156718699-eb86ad93-6468-4cc9-b6a8-f16577011e0b.png)

- 回到lab3目录下，使用```make clean```命令做清除操作。

- 再参考```Q1```的流程步骤，即可打印出```SSUUSSTTeecchh```和```IILLOOVVEEOOSS```。

![image](https://user-images.githubusercontent.com/64548919/156718914-e1080314-c959-4541-acb9-9b483dd67344.png)
