#include <stdbool.h>
#include <stdio.h>
#include "stdlib.h"

#define ERROR -1

typedef int ElementType;
typedef struct LNode *PtrToLNode;
typedef PtrToLNode Position;
typedef PtrToLNode List;

struct LNode{
    ElementType Data;
    PtrToLNode Next;
};

int Length(List L){
    Position p;
    int cnt = 0;
    p = L;
    while(p){
        p = p->Next;
        cnt++;
    }
    return cnt;
}

bool IfHeadExist(List L){
    int sum;
    Position p,h;
    p = L->Next; //pָ��ڶ�������
    h = L; //hָ���һ������
    while (p){    //�ۼӳ��˵�һ��������������д�������
        sum = sum + p->Data;
        p = p->Next;
    }
    if(sum < h->Data){
        return true;
    }else{return false;}
}

ElementType FindKth(List L, int K){
    Position p;
    int cnt = 1;
    p = L;
    while (p && cnt<K){
        p = p->Next;
        cnt++;
    }
    if((cnt == K) && p){
        if(IfHeadExist(L)){p=p->Next;return p->Data;}
        else{return p->Data;}
        }
    else{
        return ERROR;}
}

bool Insert(List L, ElementType X, int i){
    Position tmp,pre;
    int cnt = 0;

    pre = L;
    while(pre && cnt<i-1){
        pre = pre->Next;
        cnt++;
    }
    if(pre==NULL || cnt!=i-1){
        printf("����λ�ò�������\n");
        return false;
    }
    else{
        tmp = (Position)malloc(sizeof(struct LNode));
        tmp->Data=X;
        tmp->Next=pre->Next;
        pre->Next=tmp;
        return true;
    }
}

bool Delete(List L, int i){
    Position tmp, pre;
    int cnt = 0;

    pre = L;
    while (pre && cnt<i-1){
        pre = pre->Next;
        cnt++;
    }
    if(pre==NULL || cnt!=i-1 || pre->Next==NULL){
        printf("ɾ��λ�ò�������\n");
        return false;
    }
    else{
        tmp = pre->Next;
        pre->Next = tmp->Next;
        free(tmp);
        return true;
    }
}

void PrintList(List L){                      //��ӡ������������
    Position p;
    p = L;
    printf("|����%d", Length(L));
    printf("|��ǰ��������: ");
    while(p){
        printf(" �� %d �� ",p->Data);
        p = p->Next;
    }
    printf("\n\n");
}

List MakeEmpty(){
    List L;
    L = (List)malloc(sizeof(struct LNode));
    return L;
}

int main(){
    List L;
//    Position p;
//    p = L;
//    p->Data = 0;
    int i;
    printf("///�����ʼ�����...///\n");
    PrintList(L);
    printf("///���β���5����Ч������...///\n");
    for(i=1;i<=5;i++){Insert(L,i,i);}
    PrintList(L);
    printf("///���ҵ�3����Ч������...///\n");
    printf("��3����Ч�����ǣ�%d\n\n",FindKth(L,3));
//    printf("///������Ҫ���ҵ�����λ��...///\n");
//    scanf("%d",k);
//    printf("��%d����Ч������%d",k, FindKth(L,k));
    printf("///ɾ����3����Ч������...///\n");
    Delete(L,1);
    PrintList(L);
    return 0;
}