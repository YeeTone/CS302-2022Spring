#include <stdio.h>
#include <string.h>
struct AGE
{
    int year;
    int month;
    int day;
};
struct STUDENT
{
    char name[20]; 
    int num;  
    struct AGE birthday; 
    float score;  
};
int main(void)
{
    struct STUDENT student1; 
    struct STUDENT *p = NULL;  
    p = &student1;  
    // ----start----
    // 1. 填空，完成名字赋值(将下划线替换成你的代码)
    strcpy(p->name, "OS_Bob");
    // 2. 设置出生年月为2001-2-23
    p->birthday.year = 2001;
    p->birthday.month = 2;
    p->birthday.day = 23;
   
    
   	// 3. 填空，学号和分数设置为12100001和100(将下划线替换成你的代码)
    p->num = 12100001;
    p->score = 100;
    
    
    // 4.请将相关信息打印到屏幕上，并截图

    printf("name: %s, num: %d, score: %f\n", p->name,p->num, p->score);
    printf("birthday: %d-%02d-%02d", p->birthday.year,p->birthday.month,p->birthday.day);
    
    // ----end----
    return 0;
}