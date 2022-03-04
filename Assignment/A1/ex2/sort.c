#include <stdio.h>
#include <stdlib.h>

struct Student
{
	int number;
	int score;
};

int cmp(const void* a, const void* b){
    struct Student s1 = *(struct Student*)a;
    struct Student s2 = *(struct Student*)b;

    if(s1.score != s2.score){
        return s1.score > s2.score;
    }else {
        return s1.number > s2.number;
    }
}

int main()
{
    int n;
    scanf("%d", &n);

    struct Student* students = NULL;
    students = (struct Student*) malloc(n * sizeof(struct Student));

    for (int i = 0; i < n; ++i) {
        scanf("%d %d", &students[i].number, &students[i].score);
    }

    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            if(cmp(&students[i], &students[j])){
                struct Student temp = students[i];
                students[i] = students[j];
                students[j] = temp;
            }
        }
    }


    printf("Output:\n");
    for (int i = 0; i < n; ++i) {
        printf("%d %d\n", students[i].number, students[i].score);
    }

    free(students);
    students = NULL;

    return 0;

} 