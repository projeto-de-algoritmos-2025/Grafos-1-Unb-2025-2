class Solution {
  int longestCycle(List<int> edges) {
    int n = edges.length;
    List<int> visitedState = List.filled(
      n,
      0,
    ); // 0: unvisited, 1: visiting, 2: visited
    List<int> distFromPathStart = List.filled(n, -1);
    int maxCycleLength = -1;

    for (int startNode = 0; startNode < n; startNode++) {
      if (visitedState[startNode] != 0) continue;

      int currentNode = startNode;
      int currentDistance = 0;

      // Use a stack to simulate recursion
      List<int> stack = [];
      List<int> distances = [];

      while (currentNode != -1) {
        if (visitedState[currentNode] == 1) {
          // Found a cycle
          int cycleLength = currentDistance - distFromPathStart[currentNode];
          if (cycleLength > maxCycleLength) {
            maxCycleLength = cycleLength;
          }
          break;
        }

        if (visitedState[currentNode] == 2) {
          // Already fully processed this node
          break;
        }

        // Mark as visiting and record distance
        visitedState[currentNode] = 1;
        distFromPathStart[currentNode] = currentDistance;

        // Push current state to stack
        stack.add(currentNode);
        distances.add(currentDistance);

        // Move to next node
        currentNode = edges[currentNode];
        currentDistance++;
      }

      // Mark all nodes in this path as fully visited
      for (int node in stack) {
        visitedState[node] = 2;
      }
    }

    return maxCycleLength;
  }
}
