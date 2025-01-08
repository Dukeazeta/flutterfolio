import 'package:flutter/material.dart';
import 'dart:math' as math;

class Particle {
  Offset position;
  double speed;
  double size;
  double opacity;
  double direction;

  Particle({
    required this.position,
    required this.speed,
    required this.size,
    required this.opacity,
    required this.direction,
  });
}

class ParticleBackground extends StatefulWidget {
  final int numberOfParticles;
  final Color particleColor;

  const ParticleBackground({
    super.key,
    this.numberOfParticles = 50,
    this.particleColor = Colors.white,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  late AnimationController _controller;
  final math.Random random = math.Random();

  @override
  void initState() {
    super.initState();
    _initializeParticles();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  void _initializeParticles() {
    particles = List.generate(
      widget.numberOfParticles,
      (index) => _createParticle(Offset.zero),
    );
  }

  Particle _createParticle(Offset size) {
    return Particle(
      position: Offset(
        random.nextDouble() * (size.dx == 0 ? 1000 : size.dx),
        random.nextDouble() * (size.dy == 0 ? 1000 : size.dy),
      ),
      speed: random.nextDouble() * 0.5 + 0.1,
      size: random.nextDouble() * 3 + 1,
      opacity: random.nextDouble() * 0.6 + 0.1,
      direction: random.nextDouble() * 2 * math.pi,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Reinitialize particles with actual size if needed
        if (particles.first.position == Offset.zero) {
          particles = List.generate(
            widget.numberOfParticles,
            (index) => _createParticle(Offset(constraints.maxWidth, constraints.maxHeight)),
          );
        }

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: ParticlePainter(
                particles: particles,
                color: widget.particleColor,
                progress: _controller.value,
              ),
            );
          },
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Color color;
  final double progress;

  ParticlePainter({
    required this.particles,
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var particle in particles) {
      // Update position
      final dx = math.cos(particle.direction) * particle.speed * progress * size.width;
      final dy = math.sin(particle.direction) * particle.speed * progress * size.height;
      
      particle.position = Offset(
        (particle.position.dx + dx) % size.width,
        (particle.position.dy + dy) % size.height,
      );

      // Draw particle
      paint.color = color.withOpacity(particle.opacity);
      canvas.drawCircle(particle.position, particle.size, paint);

      // Draw connections
      for (var otherParticle in particles) {
        final distance = (particle.position - otherParticle.position).distance;
        if (distance < 100) {
          paint.color = color.withOpacity((1 - distance / 100) * 0.2);
          canvas.drawLine(particle.position, otherParticle.position, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
