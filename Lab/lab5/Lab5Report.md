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
- 寻找stvec寄存器（中断向量表基址）中的值
- 跳转到这个位置进行中断处理
  - 保存上下文：使用汇编语言实现， 将所有寄存器保存到栈顶
  - 中断处理：寄存器`cause CSR`（CSR: Control and Status Register）写入一个指示导致trap产生的原因的数值。中断处理工作有中断处理和异常处理两种，会根据中断或者异常的不同类型完成处理。
  - 恢复上下文：恢复顺序与保存顺序相反，先加载两个CSR，再加载通用寄存器。



## Q2 非法指令异常实现
