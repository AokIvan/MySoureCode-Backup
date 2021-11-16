#include <stdio.h>
#include <stdbool.h>
#include "stdlib.h"
#define ERROR -1
#define MaxSize 10
typedef int Position;
typedef int ElementType;
typedef struct LNode * PtrToLNode;
typedef PtrToLNode List;
struct LNode{
    ElementType Data[MaxSize];
    Position Last;
};
List MakeEmpty(){                            //���ձ���
    List L;
    L = (List)malloc(sizeof(struct LNode));
    L->Last=-1;
    return L;
}
Position Find(List L,ElementType X){         //�����
    Position i = 0;
    while (i<=L->Last && L->Data[i]!=X){i++;}
    if(i > L->Last) return ERROR;
    else return i;
}
bool Insert(List L,ElementType X,int i){     //�����
    Position j;
    if(L->Last == MaxSize-1){
        printf("����\n");
        return false;
    }
    if(i<1 || i>L->Last+2){
        printf("λ�򲻺Ϸ�\n");
        return false;
    }
    for(j=L->Last;j>=i-1;j--)
        L->Data[j+1]=L->Data[j];
    L->Data[i-1]=X;
    L->Last++;
    return true;
}
bool Delete(List L,int i){                   //ɾ����
    Position j;
    if(i<1 || i>L->Last+1){
        printf("λ��%d������Ԫ��\n",i);
        return false;
    }
    for(j=i;j<=L->Last;j++)
        L->Data[j-1]=L->Data[j];
    L->Last--;
    return true;
}
int Length(List L){                          //ͨ����λ�������һλ���
    return L->Last+1;
}
void PrintList(List L){                      //��ӡ������������
    int i;
    printf("��ǰ��������: ");
    for(i=0;i<= L->Last;i++){
        printf(" �� %d �� ",L->Data[i]);
    }
    printf("\n");
}
main(){
    List L;
    L = MakeEmpty();
    Insert(L,1,1);
    Insert(L,2,2);
    Insert(L,3,3);
    Insert(L,4,4);

    PrintList(L);
    printf("����%d\n",Length(L));

    Find(L,4);
    printf("ɾ��һ��\n");
    Delete(L,2);
    PrintList(L);
    Find(L,4);

    printf("����%d\n",Length(L));

    Insert(L,2,2);
    Insert(L,0,3);
    PrintList(L);
    Find(L,3);
    Find(L,4);
    return 0;
}