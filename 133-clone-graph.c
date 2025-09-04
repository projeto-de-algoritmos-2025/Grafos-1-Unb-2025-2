#include <stdio.h>
#include <stdlib.h>

struct Node {
    int val;
    int numNeighbors;
    struct Node** neighbors;
};

// DFS para clonar
struct Node* cloneGraphDFS(struct Node* node, struct Node** clones) {
    if (node == NULL) return NULL;

    // se já clonamos esse nó, retornamos uma cópiaa
    if (clones[node->val] != NULL) {
        return clones[node->val];
    }

    // criamos o clone
    struct Node* copy = (struct Node*)malloc(sizeof(struct Node));
    copy->val = node->val;
    copy->numNeighbors = node->numNeighbors;
    copy->neighbors = (struct Node**)malloc(sizeof(struct Node*) * node->numNeighbors);

    clones[node->val] = copy;

    // clona recursivamente cada vizinho
    for (int i = 0; i < node->numNeighbors; i++) {
        copy->neighbors[i] = cloneGraphDFS(node->neighbors[i], clones);
    }
    return copy;
}

struct Node* cloneGraph(struct Node* node) {
    struct Node* clones[101] = { NULL }; // índice = valor do nó, 1 <= Node.val <= 100
    return cloneGraphDFS(node, clones);
}


// função auxiliar para imprimir o grafo
void printGraph(struct Node* node, int visited[101]) {
    if (!node || visited[node->val]) return;
    visited[node->val] = 1;
    printf("Node %d: ", node->val);
    for (int i = 0; i < node->numNeighbors; i++) {
        printf("%d ", node->neighbors[i]->val);
    }
    printf("\n");
    for (int i = 0; i < node->numNeighbors; i++) {
        printGraph(node->neighbors[i], visited);
    }
}

int main() {
    // cria um grafo simples: 1-2-3-4-1 (ciclo)
    struct Node* n1 = (struct Node*)malloc(sizeof(struct Node));
    struct Node* n2 = (struct Node*)malloc(sizeof(struct Node));
    struct Node* n3 = (struct Node*)malloc(sizeof(struct Node));
    struct Node* n4 = (struct Node*)malloc(sizeof(struct Node));

    n1->val = 1; n2->val = 2; n3->val = 3; n4->val = 4;
    n1->numNeighbors = 2; n2->numNeighbors = 2; n3->numNeighbors = 2; n4->numNeighbors = 2;

    struct Node* arr1[2] = {n2, n4}; n1->neighbors = arr1;
    struct Node* arr2[2] = {n1, n3}; n2->neighbors = arr2;
    struct Node* arr3[2] = {n2, n4}; n3->neighbors = arr3;
    struct Node* arr4[2] = {n1, n3}; n4->neighbors = arr4;

    // cvlona o grafo
    struct Node* clone = cloneGraph(n1);

    // original
    printf("Original:\n");
    int visited[101] = {0};
    printGraph(n1, visited);

    // clone
    printf("\nClone:\n");
    for (int i = 0; i < 101; i++) visited[i] = 0;
    printGraph(clone, visited);

    return 0;
}