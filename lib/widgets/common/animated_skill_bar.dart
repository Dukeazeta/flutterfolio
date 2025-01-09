import 'package:flutter/material.dart';

class AnimatedSkillBar extends StatefulWidget {
  final String skill;
  final double percentage;
  final Color color;
  final String description;

  const AnimatedSkillBar({
    super.key,
    required this.skill,
    required this.percentage,
    required this.color,
    required this.description,
  });

  @override
  State<AnimatedSkillBar> createState() => _AnimatedSkillBarState();
}

class _AnimatedSkillBarState extends State<AnimatedSkillBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.percentage,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.skill,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  '${(_animation.value * 100).toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: widget.color,
                        fontWeight: FontWeight.bold,
                      ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          widget.description,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Row(
                children: [
                  Expanded(
                    flex: (_animation.value * 100).toInt(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: [
                            widget.color.withOpacity(0.7),
                            widget.color,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (100 - (_animation.value * 100)).toInt(),
                    child: const SizedBox(),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
