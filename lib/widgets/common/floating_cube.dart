import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingCube extends StatefulWidget {
  final double size;
  final Color color;

  const FloatingCube({
    super.key,
    this.size = 100,
    required this.color,
  });

  @override
  State<FloatingCube> createState() => _FloatingCubeState();
}

class _FloatingCubeState extends State<FloatingCube>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationX;
  late Animation<double> _rotationY;
  late Animation<double> _rotationZ;
  late Animation<double> _hover;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _rotationX = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.linear),
    ));

    _rotationY = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.linear),
    ));

    _rotationZ = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.linear),
    ));

    _hover = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _hover.value),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_rotationX.value * 0.5)
              ..rotateY(_rotationY.value * 0.5)
              ..rotateZ(_rotationZ.value * 0.3),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(widget.size * 0.2),
                border: Border.all(
                  color: widget.color.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: CustomPaint(
                painter: CubePatternPainter(
                  color: widget.color.withOpacity(0.3),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CubePatternPainter extends CustomPainter {
  final Color color;

  CubePatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final spacing = size.width / 4;

    // Draw vertical lines
    for (var i = 1; i < 4; i++) {
      canvas.drawLine(
        Offset(spacing * i, 0),
        Offset(spacing * i, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (var i = 1; i < 4; i++) {
      canvas.drawLine(
        Offset(0, spacing * i),
        Offset(size.width, spacing * i),
        paint,
      );
    }

    // Draw diagonal lines
    canvas.drawLine(
      Offset(0, 0),
      Offset(size.width, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(0, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(CubePatternPainter oldDelegate) => false;
}
