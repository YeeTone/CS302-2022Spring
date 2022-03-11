# Week4 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 父子进程区分 & 执行顺序

### Q1-1 父子进程区分
考虑使用```man fork```指令查看相关文档说明，并找到下图中的说明：

![image](https://user-images.githubusercontent.com/64548919/157819578-8ead2db1-e151-4319-a250-3457b4775806.png)

注意红色框中的话：如果父进程使用```fork```，则返回数值为子进程的```pid```；如果子进程使用```fork```，则返回数值为0。

因此父子进程的区分方法是根据```fork```方法的返回值。

### Q1-2 执行顺序
考虑课件中的代码：

```C
#include <stdio.h> 
#include <unistd.h>
int main(int argc, char *argv[]){ 
  printf("A\n"); 
  fork(); 
  printf("B\n"); 
  fork();
  printf("C\n");
  return 0; 
}
```

进行多次运行，发现其中的运行结果会不一致：

![image](https://user-images.githubusercontent.com/64548919/157819275-e2b9d3be-70b3-4afa-b56f-47f6d51d5633.png)

因此可知父子进程的执行顺序是不固定的。

## Q2 waitpid()函数原型，参数含义，与具体功能

### Q2-1 函数原型
考虑使用```man waitpid```指令查看相关文档说明，并找到下图中的说明：

![image](https://user-images.githubusercontent.com/64548919/157819931-bec122f0-4f08-4818-aa14-080b62b1a225.png)

课件waitpid的函数原型为：

```C
pid_t waitpid(pid_t pid, int *wstatus, int options);
```

### Q2-2 参数含义
在文档说明中找到对应参数：

![image](https://user-images.githubusercontent.com/64548919/157820483-df5e45e0-0bfb-49bb-ba7e-384563ff6ae2.png)

- 参数pid
  - 表示进程的等待状态
  - >0：只等待进程id等同于```pid```的子进程
  - -1：等待所有子进程退出，效果等同于```wait```
  - =0: 等待同一进程组的任何子进程
  - <-1：等待一个指定进程组的所有子进程，其中进程组的id为pid的绝对值。

- 参数wstatus
  - 表示传出的参数，如果设为NULL则表示无需传出该参数

- 参数options
  - 表示来控制```waitpid```的提供额外选项
  - WNOHANG：非阻塞的，立即返回，不等待子进程的状态发生变化
  - WUNTRACED：
  - WCONTINUED

## Q3 僵尸进程情况4

## Q4 僵尸进程代码实现与状态截图

## Q5 子进程exec实现"ps -al"

## Q6 pipe中父子进程的功能
