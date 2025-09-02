import 'package:flutter/material.dart';
import 'widgets/color_grid.dart';
import 'widgets/color_palette.dart';
import 'widgets/tool_selector.dart';
import 'widgets/fill_animation_controller.dart';

void main() {
  runApp(const ColorFillApp());
}

class ColorFillApp extends StatelessWidget {
  const ColorFillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Fill Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ColorFillGame(),
    );
  }
}

class ColorFillGame extends StatefulWidget {
  const ColorFillGame({super.key});

  @override
  State<ColorFillGame> createState() => _ColorFillGameState();
}

class _ColorFillGameState extends State<ColorFillGame> {
  // Grid configuration
  static const int gridSize = 10; // 10x10 grid
  static const double squareSize = 24.0;

  // Available colors
  final List<Color> availableColors = [
    Colors.red,
    Colors.green,
    Colors.black,
    Colors.white,
  ];

  // Game state
  Color selectedColor = Colors.red;
  String selectedTool = 'single'; // 'single' or 'fill'
  late List<List<Color>> grid;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    // Initialize grid with white squares
    grid = List.generate(
      gridSize,
      (i) => List.generate(gridSize, (j) => Colors.white),
    );
  }

  void _onSquareTap(int row, int col) {
    if (isAnimating) return; // Prevent interaction during animation

    setState(() {
      if (selectedTool == 'single') {
        // Single paint: change only the tapped square
        grid[row][col] = selectedColor;
      } else if (selectedTool == 'fill') {
        // Fill tool: animate fill using BFS
        _animateFill(row, col);
      }
    });
  }

  void _animateFill(int startRow, int startCol) {
    final targetColor = grid[startRow][startCol];

    setState(() {
      isAnimating = true;
    });

    final controller = FillAnimationController(
      grid: grid,
      gridSize: gridSize,
      updateSquare: (row, col, color) {
        setState(() {
          grid[row][col] = color;
        });
      },
      onAnimationComplete: () {
        setState(() {
          isAnimating = false;
        });
      },
    );

    controller.animateFill(startRow, startCol, targetColor, selectedColor);
  }

  void _resetGrid() {
    setState(() {
      grid = List.generate(
        gridSize,
        (i) => List.generate(gridSize, (j) => Colors.white),
      );
      isAnimating = false;
    });
  }

  void _onColorSelected(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void _onToolSelected(String tool) {
    setState(() {
      selectedTool = tool;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight =
        screenHeight - appBarHeight - statusBarHeight - 32; // 32 for padding

    // Calculate if we need horizontal layout
    final gridTotalSize =
        _ColorFillGameState.gridSize * _ColorFillGameState.squareSize;
    final controlsHeight = 200; // Approximate height needed for controls
    final useHorizontalLayout =
        availableHeight < (gridTotalSize + controlsHeight + 40);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Fill Game'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: useHorizontalLayout
            ? _buildHorizontalLayout()
            : _buildVerticalLayout(),
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      children: [
        // Grid of squares with fixed size
        ColorGrid(
          grid: grid,
          onSquareTap: _onSquareTap,
          gridSize: gridSize,
          squareSize: squareSize,
        ),

        const SizedBox(height: 20),

        // Color palette
        ColorPalette(
          availableColors: availableColors,
          selectedColor: selectedColor,
          onColorSelected: _onColorSelected,
        ),

        const SizedBox(height: 16),

        // Tools
        ToolSelector(
          selectedTool: selectedTool,
          onToolSelected: _onToolSelected,
          onReset: _resetGrid,
          isAnimating: isAnimating,
        ),

        // Animation status
        if (isAnimating)
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 8),
                Text(
                  'Filling...',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Grid of squares with fixed size
        ColorGrid(
          grid: grid,
          onSquareTap: _onSquareTap,
          gridSize: gridSize,
          squareSize: squareSize,
        ),

        const SizedBox(width: 20),

        // Controls on the right
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Color palette
              ColorPalette(
                availableColors: availableColors,
                selectedColor: selectedColor,
                onColorSelected: _onColorSelected,
              ),

              const SizedBox(height: 16),

              // Tools
              ToolSelector(
                selectedTool: selectedTool,
                onToolSelected: _onToolSelected,
                onReset: _resetGrid,
                isAnimating: isAnimating,
              ),

              // Animation status
              if (isAnimating)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Filling...',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
