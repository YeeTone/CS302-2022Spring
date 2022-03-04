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

## Q3: 链接脚本的作用
- 链接器：将输入文件链接成输出文件，可以将各种代码和数据片段收集起来组合成单一文件。链接过程可能发生在编译，内存加载，程序执行的时候。
- 链接脚本：描述如何将输入文件的section，映射到输出文件的section，并规定这些section的内存布局。链接脚本用于描述链接器处理目标文件和库文件的方式，如：
  - 合并各个目标文件的段
  - 重定位各个段的起始地址
  - 重定位各个符号的最终地址

> https://blog.csdn.net/ehuangdan5864/article/details/107744789

> https://www.yisu.com/zixun/5633.html
