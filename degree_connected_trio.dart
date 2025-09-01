import 'dart:math';

class Solution {
  int minTrioDegree(int n, List<List<int>> edges) {
    List<Set<int>> graph = List.generate(n + 1, (_) => <int>{});
    List<int> degree = List.filled(n + 1, 0);

    for (List<int> edge in edges) {
      int u = edge[0];
      int v = edge[1];
      if (!graph[u].contains(v)) {
        graph[u].add(v);
        graph[v].add(u);
        degree[u]++;
        degree[v]++;
      }
    }

    int minDegree = 1 << 30;
    bool foundTrio = false;

    for (List<int> edge in edges) {
      int u = edge[0];
      int v = edge[1];

      if (degree[u] > degree[v] || (degree[u] == degree[v] && u > v)) {
        int tmp = u;
        u = v;
        v = tmp;
      }

      for (int w in graph[u]) {
        if (w == v) continue;
        if (graph[v].contains(w)) {
          foundTrio = true;
          int trioDegree = degree[u] + degree[v] + degree[w] - 6;
          if (trioDegree < minDegree) minDegree = trioDegree;
          if (minDegree == 0) return 0;
        }
      }
    }

    return foundTrio ? minDegree : -1;
  }
}

void main() {
  Solution solution = Solution();

  int n1 = 6;
  List<List<int>> edges1 = [
    [1, 2],
    [1, 3],
    [3, 2],
    [4, 1],
    [5, 2],
    [3, 6],
  ];
  int result1 = solution.minTrioDegree(n1, edges1);
  print("Test 1: n=$n1, edges=$edges1");
  print("Result: $result1");

  int n2 = 7;
  List<List<int>> edges2 = [
    [1, 3],
    [4, 1],
    [4, 3],
    [2, 5],
    [5, 6],
    [6, 7],
    [7, 5],
    [2, 6],
  ];
  int result2 = solution.minTrioDegree(n2, edges2);
  print("\nTest 2: n=$n2, edges=$edges2");
  print("Result: $result2");

  int n3 = 4;
  List<List<int>> edges3 = [
    [1, 2],
    [3, 4],
  ];
  int result3 = solution.minTrioDegree(n3, edges3);
  print("\nTest 3: n=$n3, edges=$edges3");
  print("Result: $result3");

  int n4 = 5;
  List<List<int>> edges4 = [
    [1, 2],
    [2, 3],
    [3, 1],
    [1, 4],
    [2, 4],
    [3, 4],
    [1, 5],
    [2, 5],
    [3, 5],
  ];
  int result4 = solution.minTrioDegree(n4, edges4);
  print("\nTest 4: n=$n4, edges=$edges4");
  print("Result: $result4");

  print("\nTest 5: Large test case (n=400)");
  int n5 = 400;
  List<List<int>> edges5 = [];

  for (int i = 1; i <= n5; i++) {
    for (int j = i + 1; j <= min(i + 10, n5); j++) {
      edges5.add([i, j]);
    }
  }

  print("Created ${edges5.length} edges");
  int startTime = DateTime.now().millisecondsSinceEpoch;
  int result5 = solution.minTrioDegree(n5, edges5);
  int endTime = DateTime.now().millisecondsSinceEpoch;
  print("Result: $result5");
  print("Time taken: ${endTime - startTime}ms");
}
