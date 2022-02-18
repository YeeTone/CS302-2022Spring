# Week1 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1
实验课环境要求ubuntu系统用户名包含学号。

Ubuntu系统用户名为wyt11910104，如下图所示
![image](https://user-images.githubusercontent.com/64548919/154632213-4dfddf4b-0f25-467e-88f0-c5f9e358f585.png)


## Q2
- $表示命令提示符，前面的文字表示当前工作路径。

- 更改terminal当前执行目录路径：使用cd命令
  - cd .. 表示跳转至上级目录
  - cd (path) 表示跳转至path所在位置的目录
  - cd / 表示跳转至系统根目录
  - cd ~ 表示跳转至当前用户目录
![image](https://user-images.githubusercontent.com/64548919/154632842-b89b07a3-5490-4ef4-8685-ef4e73b56c3d.png)

## Q3
通过terminal重命名文件的方法：
- 先使用cd命令寻求到对应路径
- 使用mv命令通过移动的方法来重命名，格式为"mv 原文件名 新文件名"，如下图所示
![image](https://user-images.githubusercontent.com/64548919/154633133-f54971ae-32de-495c-a9ba-bb58fc34143b.png)

## Q4
搜索当前目录下所有.c文件的命令：
```
find *.c
```
如下图所示：
![image](https://user-images.githubusercontent.com/64548919/154633402-06f74816-2a73-4a29-b7fd-10a797ce578e.png)

## Q5
```
chmod 537 test.txt
```
考虑到537的三位二进制表示法：5 -> 101, 3 -> 011, 7 -> 111，即为r-x-wxrwx，这里表示当前目录下的test.txt文件的权限修改为：
- user：可读，不可写，可执行
- group：不可读，可写，可执行
- other：可读，可写，可执行

## Q6
- 死循环程序与PID，R+状态：
![image](https://user-images.githubusercontent.com/64548919/154634844-9ee38d8a-21eb-4357-9ee3-6a57634305ab.png)
- 进入暂停状态指令：Ctrl+Z，此时a.out进程状态变为T
![image](https://user-images.githubusercontent.com/64548919/154634953-e53914dd-d89a-40c2-82b8-3f86633cb0a5.png)
- 使用指令：fg 1，使得进程继续运行
![image](https://user-images.githubusercontent.com/64548919/154635134-bb13ca34-5600-4ed4-ba5f-9b71f21b5045.png)
- 终止当前进程：Ctrl+C
![image](https://user-images.githubusercontent.com/64548919/154635242-523de3ac-03b2-49cf-8b99-bba65c71c9d2.png)

## Q7
qemu成功运行的截图：
![image](https://user-images.githubusercontent.com/64548919/154637677-7fe90b5e-aa49-4ec4-8c7f-7e3dc9221151.png)

## Q8
qemu的退出方法：
先按Ctrl+A，然后按X退出
![image](https://user-images.githubusercontent.com/64548919/154637869-be9c16f3-294f-495d-af3f-40e413721f6a.png)

## Q9
截图安装成功的riscv-gcc编译器的版本号：9.3.0
![image](https://user-images.githubusercontent.com/64548919/154638414-f85e8f17-329f-4ed9-80e4-fa1981ef59b1.png)

## Q10
实验课课堂报告需要以pdf文件格式提交。未按照该格式提交计0分（每个人有且仅有一次提交错误格式不扣分的机会）。
![image](https://user-images.githubusercontent.com/64548919/154638605-891ce4c8-ea62-49b3-bcb8-35e5d580d136.png)

## Q11
- 本课程不允许抄袭行为。
- 如有该行为，被抄袭者与抄袭者一同受到处罚。
- 处罚：
  - 第一次抄袭，该项作业成绩为0分；第二次抄袭，该课程成绩为0分
  - 不能参加计算机系保研
  - 不能参加计算机系的各类评奖评优
  - 不能参与1+3进系
