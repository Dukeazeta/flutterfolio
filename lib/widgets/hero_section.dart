import 'package:flutter/material.dart';
import 'common/gradient_text.dart';
import 'common/glow_button.dart';
import 'common/typing_text.dart';
import 'common/floating_cube.dart';
import 'common/animated_card.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 800),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: [
          // Background cubes
          Positioned(
            right: -50,
            top: 100,
            child: FloatingCube(
              size: 200,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Positioned(
            left: 100,
            bottom: 100,
            child: FloatingCube(
              size: 150,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                AnimatedCard(
                  tiltFactor: 0.02,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.waving_hand_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Welcome to my portfolio',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const GradientText(
                  'Flutter Developer',
                  style: TextStyle(fontSize: 72),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4158D0),
                      Color(0xFFC850C0),
                      Color(0xFFFFCC70),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TypingText(
                  texts: const [
                    'Building beautiful mobile apps',
                    'Creating seamless user experiences',
                    'Transforming ideas into reality',
                  ],
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlowButton(
                      text: 'View Projects',
                      onPressed: () {},
                    ),
                    const SizedBox(width: 24),
                    GlowButton(
                      text: 'Get in Touch',
                      onPressed: () {},
                      isPrimary: false,
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                _buildStats(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatItem(context, '2+', 'Years of Experience'),
        _buildDivider(),
        _buildStatItem(context, '20+', 'Projects Completed'),
        _buildDivider(),
        _buildStatItem(context, '15+', 'Happy Clients'),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return AnimatedCard(
      tiltFactor: 0.02,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        '•',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 24,
        ),
      ),
    );
  }
}
