import 'package:flutter/material.dart';
import 'dart:math' as math;

class GridBackground extends StatelessWidget {
  final Widget child;

  const GridBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0A0A),
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: GridPainter(
              color: Colors.white.withOpacity(0.05),
              gridSize: 100,
              lineWidth: 0.5,
            ),
          ),
          CustomPaint(
            size: Size.infinite,
            painter: GridPainter(
              color: Colors.white.withOpacity(0.1),
              gridSize: 400,
              lineWidth: 1,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final Color color;
  final double gridSize;
  final double lineWidth;

  GridPainter({
    required this.color,
    required this.gridSize,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    // Draw vertical lines
    for (double x = 0; x <= size.width + gridSize; x += gridSize) {
      final path = Path();
      path.moveTo(x, 0);
      path.lineTo(x, size.height);
      canvas.drawPath(path, paint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height + gridSize; y += gridSize) {
      final path = Path();
      path.moveTo(0, y);
      path.lineTo(size.width, y);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) =>
      color != oldDelegate.color ||
      gridSize != oldDelegate.gridSize ||
      lineWidth != oldDelegate.lineWidth;
}
