# Week11 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 `user\rr.c` 进程调度

1. 主进程通过循环fork产生5个编号分别为3,4,5,6,7的子进程；

![image](https://user-images.githubusercontent.com/64548919/165903672-adf4770d-51d1-4660-81d3-99157bbd99aa.png)

2. 主进程循环fork完成后，进入cprintf和下一for循环，for循环里面操作的内容是waitpid（本质上是sys_wait）；

![image](https://user-images.githubusercontent.com/64548919/165903714-b0f79b10-fe24-4d52-b432-ce2bc0ac82fe.png)

3. 主进程调用waitpid时，依次确认是否是僵尸状态

   -> 是：收回释放资源
   
   -> 否：主进程开始调度至子进程执行
4. 从主进程调度至子进程后，开始进入先前fork的位置并执行while(1)循环，并在循环过程中依次调度执行其他的子进程（以4000次循环为一个单位）。时间超过了以后，就会执行正常的退出操作并将自身状态设置为僵尸态以通知主进程并让主进程清理资源。

![image](https://user-images.githubusercontent.com/64548919/165903756-da12289e-4d64-4cba-8f98-7055ef705eb9.png)

5. 当所有进程流程都执行完成了，主进程即可返回正常结束。

![image](https://user-images.githubusercontent.com/64548919/165903784-c4691e83-235a-43b6-8720-749f29e911f0.png)
