# Week2 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1

命令行命令：
```
vim Q1.c
gcc Q1.c
./a.out
```

Q1.c 中的代码：
```C
#include <math.h>
#include <stdio.h>
int main(){
        printf("%lf\n",sqrt(2.0));
        return 0;
}

```

命令行运行截图：


![QQ截图20220225143431](https://user-images.githubusercontent.com/64548919/155666590-fc534fd5-31ae-43de-91eb-48f914cb71b9.png)

## Q2

命令行命令：
```
vim Q2.c
gcc -o Q2.o Q2.c
./Q2.o
file Q2.o
```

Q2.c 中的代码：
```C
#include <stdio.h>

int main(){
        printf("%s %d\n","Yitong WANG", 11910104);
        return 0;
}

```

命令行运行截图：

![image](https://user-images.githubusercontent.com/64548919/155667564-02140784-7a6f-47dc-9eed-a24f4d492c14.png)

## Q3
C语言的编译过程主要有以下几个步骤：
- 预处理：主要是
  - 处理一些其中的伪指令，如#define等等
  - 处理头文件包含指令，如#include等等
  - 处理条件编译指令，如#ifdef等等
- 编译优化
  - 编译会通过词法分析和语法分析，进行语法检查，并翻译成中间代码和汇编代码
  - 优化过程是对中间代码的优化，也有对目标代码生成的优化
- 汇编和链接
  - 汇编会将汇编语言代码翻译成目标机器指令，得到相应的目标文件
  - 链接主要会将有关的目标文件相连接，确保不同文件之间的定义可以连接起来

（参考：https://blog.csdn.net/weixin_40756041/article/details/88052207 ）

## Q4
考虑将Q2.c通过gcc编译，在Windows 10和Ubuntu 20.04下生成可执行文件：
- Windows系统：

![image](https://user-images.githubusercontent.com/64548919/155668513-cc869616-3c2f-4f62-919f-4b3ace950f97.png)

- Ubuntu系统：

![image](https://user-images.githubusercontent.com/64548919/155668697-5e1f35db-2117-47b7-b042-a506aafb5d36.png)

然后使用file命令，在Ubuntu系统下查看对应文件格式：

![image](https://user-images.githubusercontent.com/64548919/155668845-e727ebf3-17fb-43ff-8ecb-b9b3a55b9ff1.png)

可见对应可执行文件的格式：
- Windows: PE32+ executable
- Ubuntu: ELF 64-bit LSB shared object

## Q5
### Q1.c
- 命令行命令：
```
vim makefile
make
./Q1.o
```
- makefile内容：
```
Q1.o: Q1.c
	gcc -o Q1.o Q1.c
clean:
	rm Q1.o
```

- 运行截图：

![image](https://user-images.githubusercontent.com/64548919/155673450-a33a0046-8f60-41ab-8140-dc075c348e60.png)


### Q2.c
- 命令行命令：
```
vim makefile
make
./Q2.o
make clean
```
- makefile内容：
```
Q2.o: Q2.c
	gcc -o Q2.o Q2.c
clean:
	rm Q2.o
```
- 运行截图：

![image](https://user-images.githubusercontent.com/64548919/155673154-627c2c27-2ebe-45f5-916e-d7b5dfb154e2.png)

