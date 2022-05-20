# Week14 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 手册第二部分中的inode，如果block_size是4KB，指针大小是4B，一个inode能管理的最大文件大小是多少，写出计算过程。

Result = Direct + Single + Double + Triple
= 12\*block_size + block_size/pointer_size * block_size + (block_size/pointer_size)^2 * block_size + (block_size/pointer_size)^3 * block_size
= 12\*4Kb + 1024\*4Kb + 1024\*1024\*4Kb + 1024\*1024\*1024\*4Kb
= 48KB + 4MB + 4GB + 4TB
## Q2 SFS中的inode可以管理的最大文件大小是多少，写出计算过程。

Result = Direct + Single + Double + Triple
= 12\*block_size + block_size/pointer_size * block_size
= 12\*4Kb + 1024\*4Kb
= 48KB + 4MB

## Q3 SFS中sfs_disk_inode和sfs_disk_entry的关系是什么。
sfs_disk_inode记录了文件或者目录内容存储的索引信息。

sfs_disk_entry表示一个目录中的一个文件或者目录。

sfs_disk_inode代表了一个实际位于磁盘上的文件/目录。对于普通文件，索引值指向的 block 中保存的是文件中的数据。而对于目录，索引值指向的数据保存的
是目录下所有的文件名以及对应的索引节点所在的索引块（磁盘块）所形成的数组，即由`sfs_disk_entry`组成。
