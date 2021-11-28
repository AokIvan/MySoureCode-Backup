#include<stdio.h>
#include<stdlib.h>
typedef char ElementType;
typedef struct TNode *Position; /* �ṹ��ָ�� */
typedef Position BinTree; /* ���������� */
struct TNode{ /* ����㶨�� */
    ElementType Data; /* ������� */
    BinTree Left;     /* ָ�������� */
    BinTree Right;    /* ָ�������� */
}TNode;

void CreateBinaryTree ( BinTree *T ) {
    ElementType ch;
    scanf("%c",&ch);
    if (ch == '#')
        *T = NULL;
    else {
        *T = (BinTree)malloc(sizeof(TNode));
        (*T)->Data = ch;
        CreateBinaryTree(&((*T)->Left));
        CreateBinaryTree(&((*T)->Right));
    }
}

void PreOrderTraversal ( BinTree BT ) {
    if ( BT ) {
        printf("%c", BT->Data);
        PreOrderTraversal( BT->Left );
        PreOrderTraversal( BT->Right );
    }
}

void InOrderTraversal ( BinTree BT ) {
    if ( BT ) {
        InOrderTraversal( BT->Left );
        printf("%c", BT->Data);
        InOrderTraversal( BT->Right );
    }
}

void PostOrderTraversal ( BinTree BT ) {
    if ( BT ) {
        PostOrderTraversal( BT->Left );
        PostOrderTraversal( BT->Right );
        printf("%c", BT->Data);
    }
}

int main() {
    BinTree myTree;
    printf("Create your Binary Tree:\n");
    CreateBinaryTree(&myTree);
    printf("\n PreOrder:");
    PreOrderTraversal(myTree);
    printf("\n InOrder:");
    InOrderTraversal(myTree);
    printf("\n PostOrder:");
    PostOrderTraversal(myTree);
    return 0;
}