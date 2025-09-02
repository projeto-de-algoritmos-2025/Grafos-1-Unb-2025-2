import 'package:flutter/material.dart';

class FillAnimationController {
  final List<List<Color>> grid;
  final int gridSize;
  final Function(int, int, Color) updateSquare;
  final VoidCallback onAnimationComplete;

  FillAnimationController({
    required this.grid,
    required this.gridSize,
    required this.updateSquare,
    required this.onAnimationComplete,
  });

  Future<void> animateFill(
    int startRow,
    int startCol,
    Color targetColor,
    Color newColor,
  ) async {
    if (targetColor == newColor) {
      onAnimationComplete();
      return;
    }

    // BFS implementation
    final queue = <List<int>>[];
    final visited = <String>{};

    // Add starting position
    queue.add([startRow, startCol]);
    visited.add('$startRow,$startCol');

    const delay = Duration(
      milliseconds: 100,
    ); // 100ms delay between each square

    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      final row = current[0];
      final col = current[1];

      // Update current square
      updateSquare(row, col, newColor);

      // Wait before processing next square
      await Future.delayed(delay);

      // Check all 4 neighbors (top, bottom, left, right)
      final neighbors = [
        [row - 1, col], // Top
        [row + 1, col], // Bottom
        [row, col - 1], // Left
        [row, col + 1], // Right
      ];

      for (final neighbor in neighbors) {
        final neighborRow = neighbor[0];
        final neighborCol = neighbor[1];
        final neighborKey = '$neighborRow,$neighborCol';

        // Check bounds
        if (neighborRow < 0 ||
            neighborRow >= gridSize ||
            neighborCol < 0 ||
            neighborCol >= gridSize) {
          continue;
        }

        // Check if already visited
        if (visited.contains(neighborKey)) {
          continue;
        }

        // Check if neighbor has the target color
        if (grid[neighborRow][neighborCol] == targetColor) {
          queue.add([neighborRow, neighborCol]);
          visited.add(neighborKey);
        }
      }
    }

    onAnimationComplete();
  }
}
