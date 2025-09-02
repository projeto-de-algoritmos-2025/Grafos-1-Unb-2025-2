import 'package:flutter/material.dart';

class ToolSelector extends StatelessWidget {
  final String selectedTool;
  final Function(String) onToolSelected;
  final VoidCallback onReset;
  final bool isAnimating;

  const ToolSelector({
    super.key,
    required this.selectedTool,
    required this.onToolSelected,
    required this.onReset,
    required this.isAnimating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          const Text(
            'Tools',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Single paint tool
              GestureDetector(
                onTap: () => onToolSelected('single'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: selectedTool == 'single'
                        ? Colors.blue
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.brush,
                        color: selectedTool == 'single'
                            ? Colors.white
                            : Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Single Paint',
                        style: TextStyle(
                          color: selectedTool == 'single'
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Fill tool
              GestureDetector(
                onTap: () => onToolSelected('fill'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: selectedTool == 'fill'
                        ? Colors.blue
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.format_color_fill,
                        color: selectedTool == 'fill'
                            ? Colors.white
                            : Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Fill',
                        style: TextStyle(
                          color: selectedTool == 'fill'
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Reset button
              GestureDetector(
                onTap: isAnimating ? null : onReset,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isAnimating
                        ? Colors.grey.shade400
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isAnimating
                          ? Colors.grey.shade500
                          : Colors.red.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: isAnimating
                            ? Colors.grey.shade600
                            : Colors.red.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Reset',
                        style: TextStyle(
                          color: isAnimating
                              ? Colors.grey.shade600
                              : Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
