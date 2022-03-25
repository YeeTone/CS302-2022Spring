# Week6 Report
姓名：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

学号：11910104

实验课时段：周五5-6节

实验课教师：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

实验课SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## Q1 `le2page`宏展开与工作原理
### Q1-1 宏展开
先在`kern/mm/memlayout.h`中寻找`le2page`的相关宏定义，如下：

![image](https://user-images.githubusercontent.com/64548919/160065521-813a62e2-13da-467e-bd94-671e4a383b44.png)

然后在`libs/defs.h`中继续寻找宏定义，如下：

![image](https://user-images.githubusercontent.com/64548919/160065946-212c11f7-cca3-4cbd-bfb6-1862c0bc435f.png)

现考虑85行的对应代码：

![image](https://user-images.githubusercontent.com/64548919/160066483-a63d2562-4612-47d8-ad1b-a663a01fd091.png)

做逐步展开，如下：
```C
le2page(le, page_link)

to_struct((le), struct Page, page_link)

((struct Page*)((char*)((le)) - offsetof(struct Page, page_link)))

((struct Page*)((char*)((le)) - ((size_t)(&((struct Page*)0) -> page_link))))
```

### Q1-2 工作原理

先查看`Page`结构体的定义，位置在`kern/mm/memlayout.h`：

![image](https://user-images.githubusercontent.com/64548919/160068191-1f7b2538-8935-4dd0-97ce-7099ee83f58f.png)

这里的工作原理是首先通过结构体中的定义得到`page_link`中的偏移位置（注意这里offset中的零指针，并非运行时访问，而是编译期就会自动计算替代），
然后就可以通过相减得到`page_link`节点所在的`Page`结构的首地址，最后做强制类型转换以获得`struct Page*`。

引用以下参考链接中的一句话：offset宏的构造，是C语言中通过结构体中某一属性地址访问所属其所在结构体的一种巧妙实现。

参考链接：https://www.bbsmax.com/A/E35pW22gJv/


## Q2 `default_alloc_pages`和`default_free_pages`的功能与实现方式
