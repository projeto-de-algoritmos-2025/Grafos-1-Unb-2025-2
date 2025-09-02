import 'package:flutter/material.dart';

class ColorGrid extends StatelessWidget {
  final List<List<Color>> grid;
  final Function(int, int) onSquareTap;
  final int gridSize;
  final double squareSize;

  const ColorGrid({
    super.key,
    required this.grid,
    required this.onSquareTap,
    required this.gridSize,
    required this.squareSize,
  });

  @override
  Widget build(BuildContext context) {
    final totalGridSize = gridSize * squareSize;

    return Center(
      child: Container(
        width: totalGridSize,
        height: totalGridSize,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: 2),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
            childAspectRatio: 1.0,
          ),
          itemCount: gridSize * gridSize,
          itemBuilder: (context, index) {
            final row = index ~/ gridSize;
            final col = index % gridSize;
            return GestureDetector(
              onTap: () => onSquareTap(row, col),
              child: Container(
                width: squareSize,
                height: squareSize,
                decoration: BoxDecoration(
                  color: grid[row][col],
                  border: Border.all(color: Colors.grey.shade300, width: 0.5),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
