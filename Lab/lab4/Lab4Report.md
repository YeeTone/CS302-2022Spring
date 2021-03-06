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

### Q2-2 参数含义与具体作用
在文档说明中找到对应参数：

![image](https://user-images.githubusercontent.com/64548919/157820483-df5e45e0-0bfb-49bb-ba7e-384563ff6ae2.png)

- 参数pid
  - 表示进程的等待状态
  - \>0：只等待进程id等同于```pid```的子进程
  - -1：等待所有子进程退出，效果等同于```wait```
  - =0: 等待同一进程组的任何子进程
  - <-1：等待一个指定进程组的所有子进程，其中进程组的id为pid的绝对值。

- 参数wstatus
  - 表示传出的参数，如果设为NULL则表示无需传出该参数
  - 如果不是NULL，则会将进程的状态返回值放入wstatus指向的整数中。

- 参数options
  - 表示来控制```waitpid```的提供额外选项
  - WNOHANG：非阻塞的，立即返回，如果没有发现已退出的子进程可收集，则返回0

## Q3 僵尸进程情况4
```
情况4：父进程不执行wait()，父进程比子进程先结束
```

这种情况即为子进程没有结束，但是父进程先结束，形成了“孤儿进程”。子进程会重新分配一个父进程，这个父进程有可能是init进程，也有可能是已注册的祖父进程。

下列代码可以验证：

```C
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>

int main(void){
	int pid = fork();
	if(pid == 0){
		sleep(10);
		printf("This is a child. Child pid = %d, ppid = %d\n", getpid(), getppid());
	}else {
		printf("This is a parent. Child = %d, pid = %d, ppid = %d\n",pid , getpid(), getppid());
		printf("After child ends.\n");
	}
	printf("Which process?\n");
	
	return 0;
}
```
这里由进程号为1510的命令行启动进程号为21105的父进程，然后父进程再生成进程号为21106的子进程。可以看到父子进程均未wait，且父进程优先于子进程结束。从以下的运行结果来看，子进程的ppid就被分配为命令行进程的pid————1510。

![image](https://user-images.githubusercontent.com/64548919/157827027-e8036234-d6df-4b44-b02b-b5839fb21db4.png)


## Q4 僵尸进程代码实现与状态截图

考虑以下C语言代码的僵尸进程实现：

![image](https://user-images.githubusercontent.com/64548919/157830951-ddea1ff5-adde-45e3-bec3-0a1603fd6a5f.png)

（代码参考：https://blog.csdn.net/lvxin15353715790/article/details/89852259 ）

这段代码首先fork以创建子进程，然后子进程只休眠5秒，而父进程休眠25秒，因此子进程先结束，产生了僵尸进程的状态。

- 截图1：运行前

![image](https://user-images.githubusercontent.com/64548919/157828988-e128c3f4-a009-4d5a-a511-2eec4d214ff3.png)

- 截图2：父子进程同时运行

![image](https://user-images.githubusercontent.com/64548919/157829051-6db74614-d20b-4498-b3c8-2248e4171f4a.png)

- 截图3：子进程已成僵尸态，父进程仍然运行

![image](https://user-images.githubusercontent.com/64548919/157829553-fd51fff9-e6bf-4d7f-b412-9cb6977774e9.png)

- 截图4：父子进程都退出

![image](https://user-images.githubusercontent.com/64548919/157829637-13cb33a0-dab5-4534-9a1d-d6629ff208fc.png)

## Q5 子进程exec实现"ps -al"

考虑以下代码以实现需求功能：

![image](https://user-images.githubusercontent.com/64548919/157830882-766f3c5e-53bc-485f-a9d0-3ef033239aba.png)

运行结果如下：

![image](https://user-images.githubusercontent.com/64548919/157831125-d1aac2b4-2a52-4be0-8707-382183a94490.png)

可以看到父进程产生了子进程，并且运行了"ps -al"，父进程再等待子进程结束后才运行输出```Parent has dead!```。

## Q6 pipe中父子进程的功能

1. 父进程创建管道```int pipe(int pipe_fd[2])``` ，其中```pipefd[2]```为两个文件描述符，```fd[0]```对应读，```fd[1]```对应写。（实验课课件内容）

2. 父进程创建子进程，父子进程共享文件描述符（即同一管道）（实验课课件内容）

3. 这段代码的运行流程是：
- 首先尝试fork创建子进程
- 根据创建的进程和接受的信号执行相应的方法：
   - SIGALRM: 子进程接收到就执行write\_data，父进程接收到就执行read\_data；
   - SIGINT：子进程接受到就执行finish\_write，父进程接收到就执行finish\_read；
- 父子进程通讯：
   - 子进程在write\_data中向父进程发送SIGALRM信号
   - 父进程在read\_data中向子进程发送SIGALRM信号
   - 子进程自己会通知自己SIGALRM信号
- Ctrl + C则会结束代码的运行流程
