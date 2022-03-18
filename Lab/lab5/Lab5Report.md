# Week5 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 `ebreak`后中断点处理
`ebreak`指令会触发一个断点中断从而进中断处理流程，简要流程如下：
- 寻找`stvec`寄存器（中断向量表基址）中的值，跳到中断处理程序的入口点
- 跳转到这个位置进行中断处理，将`__alltraps`函数的地址放入`stvec`寄存器中。
  - 保存上下文：使用汇编语言实现， 将所有寄存器保存到栈顶
  - 中断处理：寄存器`cause CSR`（CSR: Control and Status Register）写入一个指示导致trap产生的原因的数值。中断处理工作有中断处理和异常处理两种，会根据中断或者异常的不同类型完成处理。
  - 恢复上下文：恢复顺序与保存顺序相反，先加载两个CSR，再加载通用寄存器。
  - 执行`sret`，将S态转换回U态，返回到先前通过`ebreak`发生中断时，S态对应的地址。

## Q2 非法指令异常实现
按照如下步骤做依次操作：
- 修改`kern/init.c`中的汇编代码为`mret`：

![image](https://user-images.githubusercontent.com/64548919/158955793-085b8918-6d81-43f5-83a8-2d085715cd09.png)

- 修改`kern/trap/trap.c`中对于`AUSE_ILLEGAL_INSTRUCTION`的处理分支，输出相关信息：

![image](https://user-images.githubusercontent.com/64548919/158955977-0bce6d59-9887-4fc7-9295-d8ffb6c6d1e0.png)

- 重新`make qemu`即可输出相关的提示信息，其内包括异常类型与指令的地址：

![image](https://user-images.githubusercontent.com/64548919/158956271-664dd6c3-6571-4d7e-9100-0f24e1842c7d.png)
