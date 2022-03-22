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

### Q3-2 `exit()`
`exit()`主要做了以下几个流程：
- 内核释放所有该进程占用的内存
- 关闭所有该进程打开的文件列表
- 释放该进程相关的所有用户空间的内存

关于“僵尸态”：
- 该进程仍然在内核的进程表中，需要等待父进程收集它的退出码（因此该进程就处于僵尸态）
- 内核将子进程的退出码`SIGCHLD`通知父进程，等待父进程处理

关于与`wait()`的联系：
- 父进程没有处于`wait()`状态，则子进程通知的`SIGCHLD`无效，父进程不会处理；
- 父进程处于`wait()`状态，则内核会注册一个子进程的信号处理流程。
  - 处理流程是首先接收并移除`SIGCHLD`信号，其次再内核空间中移除子进程，从而解除“僵尸态
- 内核解除注册信号处理流程，并且将终止掉的子进程的pid作为wait()的返回值。

## Q4 Transferring from user to OS

### Q4-1 Three Methods
先参考课件上对于这部分内容的说明：

![image](https://user-images.githubusercontent.com/64548919/159475871-113d37f4-9290-4efe-be2f-7b98dd31e958.png)

因此CPU的控制由用户态到内核态的转换有三种可能：
- 系统调用
- 异常
- 中断

### Q4-2 Comparison
从以下几个方面比较：
#### 概念
- 系统调用：应用程序主动向OS发出服务请求
- 异常：非法指令序列，或者非法内存访问等等原因导致的指令执行失败
- 中断：硬件设备发出的处理请求

#### 产生源头
- 系统调用：应用程序请求操作系统完成相关任务，比如说fork，wait或者exec
- 异常：应用程序预料之外的行为，比如说非法的地址访问
- 中断：外部设备引起，比如说时钟中断，或者是I/O中断

#### 处理机制
- 系统调用：等待操作系统响应
- 异常：杀死当前进程，或者是重新执行产生意料之外结果的指令
- 中断：持续，等待中断处理

## Q5 Process Life Cycle

进程生命周期首先参考slide上这张图：

![image](https://user-images.githubusercontent.com/64548919/159478598-4c057e8b-f2a1-4e54-bb23-c9e3b1066787.png)

- new: 分配了PCB，但并无进程所需资源，创建工作不完整，进程不能调度运行
- ready: 进程已分配到除CPU以外的所有资源，处于CPU的等待态
- running: 进程获得CPU，正在执行
- waiting: 进程由于一些事件，不能继续执行，会释放CPU占用并进入阻塞状态
- terminated: 进程自然结束，或者异常终止。进程不再能够执行，但是仍然在系统进程表中有对应的记录，供其他进程收集。

Reason Description

- new -> ready：进程正在被创建，OS正在为其分配所需要的资源
- ready -> running：进程通过CPU调度器获得了CPU的相关资源
- running -> ready: 进程被调度，有可能是被回收了CPU资源，也有可能是系统中断
- running -> waiting：系统调用，一般是主动请求等待事件发生，或者说申请系统资源
- waiting -> ready：系统资源申请成功，或者等待请求的事件发生了
- running -> terminated：进程自然结束，或者出现了不可预料的异常使得异常终止
