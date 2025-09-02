import 'package:flutter/material.dart';

class ColorPalette extends StatelessWidget {
  final List<Color> availableColors;
  final Color selectedColor;
  final Function(Color) onColorSelected;

  const ColorPalette({
    super.key,
    required this.availableColors,
    required this.selectedColor,
    required this.onColorSelected,
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
            'Color Palette',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: availableColors.map((color) {
              return GestureDetector(
                onTap: () => onColorSelected(color),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      color: selectedColor == color
                          ? Colors.blue
                          : Colors.grey.shade400,
                      width: selectedColor == color ? 3 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: selectedColor == color
                      ? const Icon(Icons.check, color: Colors.white, size: 20)
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
