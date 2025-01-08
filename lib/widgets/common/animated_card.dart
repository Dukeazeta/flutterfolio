import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final bool enableTilt;
  final double tiltFactor;

  const AnimatedCard({
    super.key,
    required this.child,
    this.enableTilt = true,
    this.tiltFactor = 0.05,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  Offset _mousePosition = Offset.zero;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverStart() {
    setState(() => _isHovered = true);
    _controller.forward();
  }

  void _onHoverEnd() {
    setState(() {
      _isHovered = false;
      _mousePosition = Offset.zero;
    });
    _controller.reverse();
  }

  void _onMouseMove(PointerEvent event) {
    if (!widget.enableTilt) return;
    
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(event.position);
    final Offset normalizedPosition = Offset(
      (localPosition.dx / box.size.width) * 2 - 1,
      (localPosition.dy / box.size.height) * 2 - 1,
    );
    
    setState(() {
      _mousePosition = normalizedPosition;
    });
  }

  Matrix4 _calculateTransform() {
    if (!_isHovered || !widget.enableTilt) return Matrix4.identity();

    final rotationX = _mousePosition.dy * widget.tiltFactor;
    final rotationY = -_mousePosition.dx * widget.tiltFactor;

    return Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateX(rotationX)
      ..rotateY(rotationY);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverStart(),
      onExit: (_) => _onHoverEnd(),
      onHover: (event) {
        if (_isHovered) {
          _onMouseMove(event);
        }
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform(
            transform: _calculateTransform()..scale(_scaleAnimation.value),
            alignment: FractionalOffset.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(_isHovered ? 0.2 : 0),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
