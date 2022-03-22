# Assignment3 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 `Three Easy Pieces`

### Q1-1 Three Easy Pieces Explanation:
- Virtualizing（虚拟化）

参考书中第2页对于虚拟化的定义：

![image](https://user-images.githubusercontent.com/64548919/159440428-76bb91e4-3856-422e-be49-264edc9bb2aa.png)

虚拟化是指操作系统将硬件设备的物理资源进行一层抽象与转换，转换成一个更加普适，易用和强大的虚拟形式，从而实现底层硬件与上层应用的隔离，将对操作系统资源的访问提供统一抽象化的接口。

- Concurrency（并发度）

参考书中第7页对于并发度的说明：

![image](https://user-images.githubusercontent.com/64548919/159444161-e3e79be0-046f-411e-8dd1-8369a82f8c51.png)

并发度是指在操作系统同时处理多个进程的运行，但是对于任一时刻，只能有一个进程在执行，多个进程之间会相互切换着运行。

- Persistence（持久度）

书中对于持久度的说明如下：

![image](https://user-images.githubusercontent.com/64548919/159445208-311653da-60f7-474b-83b7-eec4781b9546.png)

持久度就是说操作系统的硬件和软件对于数据持久保存的能力，具体的实现有文件系统等等。

### Q1-2 Three Easy Pieces Mapping

- Virtualizing: Chapter 3-5
- Concurrency: Chapter 6-8
- Persistence: Chapter 12-15

## Q2 Context Switch

先参考书中第9页对上下文切换的说明：

![image](https://user-images.githubusercontent.com/64548919/159465809-afea0f51-a7f1-4ae1-a07a-403daff9ad4a.png)

因此上下文切换主要有以下几个步骤：

- 将前一个任务的CPU上下文（CPU寄存器和程序计数器）保存
- 加载新任务的上下文的CPU寄存器和程序计数器
- 跳转程序计数器所指向的新位置
- 运行新的任务、

## Q3 `fork()` and `exit()`

### Q3-1 `fork()`
- 系统调用机制：
  - `fork()`的系统调用将会创建一个与父进程几乎完全一样的新子进程。其中，当前进程确定自己是父进程/子进程的方法是根据`fork()`的返回值：如果是0则为子进程；否则，则是父进程环境，返回值为新创建子进程的进程ID。
  - `fork()`系统调用创建的新进程，内存布局和数据几乎完全相同。其中他们会在只读存储区共享相同的物理内存页；其余可读可写的数据段，堆栈内存等信息，每个进程是独立创建的。

- 地址空间：
  - 地址空间分布：分为四段：程序段（Code Segment），数据段（Data Segment），栈空间（Stack）和堆空间（Heap）
  - fork系统调用后，父进程和子进程共享程序段（因为该部分是共享只读的），其余部分都是独立复制出来的（因为都是可读可写，需要相互隔离）
 
- PCB:
  - PCB是进程控制块，是对程序运行的动态描述
  - `fork()`调用的时候，父进程会将PCB信息拷贝给子进程

- CPU调度器：
  - 在`fork()`创建了子进程后，CPU调度器会决定下一步哪个进程先运行。

- 上下文切换
  - 当`fork()`系统调用的时候，操作系统需要进入内核态。这时候就需要进行进程的上下文切换，需要保存PCB，程序段和数据信息。

- 返回值
  - 如返回结果是-1，则说明生成子进程失败，一般原因是进程号全部被占用了
  - 如调用fork的是父进程，则返回生成的子进程的进程id
  - 如调用fork的是子进程，则返回值为0
