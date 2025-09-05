#include <stdio.h>
#include <stdlib.h>

int dirs[4][2] = {{1,0},{-1,0},{0,1},{0,-1}};

//função DFS com memoização
int dfs(int** matrix, int m, int n, int i, int j, int** dp) {
    if (dp[i][j] != 0) return dp[i][j]; 

    // Comprimento mínimo é 1 (a própria célula)
    int maxLen = 1; 
    
    for (int d = 0; d < 4; d++) {
        int x = i + dirs[d][0];
        int y = j + dirs[d][1];
        if (x >= 0 && x < m && y >= 0 && y < n && matrix[x][y] > matrix[i][j]) {
            int len = 1 + dfs(matrix, m, n, x, y, dp);
            if (len > maxLen) maxLen = len;
        }
    }
    // salva o resultado na memória para não recalcular depois
    dp[i][j] = maxLen;
    return maxLen;
}

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) return 0;

    int m = matrixSize;
    int n = *matrixColSize;

    // alocar dp[m][n]
    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)calloc(n, sizeof(int));
    }

    int ans = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int len = dfs(matrix, m, n, i, j, dp);
            if (len > ans) ans = len;
        }
    }

    // liberar memória
    for (int i = 0; i < m; i++) free(dp[i]);
    free(dp);

    return ans;
}
