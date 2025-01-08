import 'package:flutter/material.dart';

class GradientText extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const GradientText(
    this.text, {
    super.key,
    this.fontSize = 32,
    this.fontWeight = FontWeight.bold,
  });

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Colors.purple,
              Theme.of(context).colorScheme.primary,
            ],
            stops: const [0.0, 0.5, 1.0],
            transform: GradientRotation(_animation.value * 2 * 3.14159),
          ).createShader(bounds),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
