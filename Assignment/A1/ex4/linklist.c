#include <stdio.h>
#include <stdlib.h>

typedef struct Link {
    int elem;
    struct Link *next;
} link;

int main(){
    link* first0 = NULL;
    first0 = (link*) malloc(sizeof(link));
    first0->elem = 0;
    first0->next = NULL;

    link* head = first0;

    int N;
    scanf("%d", &N);
    for (int i = 0; i < N; ++i) {
        int num;
        scanf("%d", &num);

        link* insert = NULL;
        insert = malloc(sizeof(link));
        insert->next = NULL;
        insert->elem = num;

        insert->next = head->next;
        head->next = insert;
    }

    while(head != NULL){
        printf("%d ", head->elem);
        link* temp = head;

        head = head->next;
        free(temp);
    }


    return 0;
}