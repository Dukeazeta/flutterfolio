import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
import 'common/animated_skill_bar.dart';
import 'common/gradient_text.dart';
import 'common/floating_cube.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: ResponsiveUtils.getScreenPadding(context),
      constraints: BoxConstraints(
        maxWidth: ResponsiveUtils.getMaxContentWidth(context),
      ),
      child: Column(
        children: [
          const SizedBox(height: 100),
          GradientText(
            'About Me',
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            style: TextStyle(
              fontSize:
                  Theme.of(context).textTheme.displayMedium?.fontSize ?? 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildBiography(context)),
                const SizedBox(width: 50),
                Expanded(child: _buildSkills(context)),
              ],
            )
          else
            Column(
              children: [
                _buildBiography(context),
                const SizedBox(height: 50),
                _buildSkills(context),
              ],
            ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildBiography(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Who am I?',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              Text(
                'I am currently the Lead Mobile Developer at KokoLabs, where I spearhead the development of innovative mobile solutions. With a proven track record in Flutter development, I specialize in building scalable, performant applications that deliver exceptional user experiences across platforms. My expertise spans mobile architecture, state management, and UI/UX implementation.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 30),
              _buildExperienceCard(
                context,
                icon: Icons.rocket_launch,
                title: 'Lead Mobile Developer',
                subtitle: 'at KokoLabs',
              ),
              const SizedBox(height: 15),
              _buildExperienceCard(
                context,
                icon: Icons.code,
                title: 'Flutter Expert',
                subtitle: 'Cross-platform Development',
              ),
            ],
          ),
        ),
        const Positioned(
          right: -20,
          top: -20,
          child: FloatingCube(
            size: 60,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkills(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technical Expertise',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 30),
          AnimatedSkillBar(
            skill: 'Flutter & Dart',
            percentage: 0.95,
            color: Colors.blue,
            description: 'Expert in cross-platform development',
          ),
          const SizedBox(height: 20),
          AnimatedSkillBar(
            skill: 'Mobile Architecture',
            percentage: 0.90,
            color: Colors.purple,
            description: 'Clean Architecture, SOLID principles',
          ),
          const SizedBox(height: 20),
          AnimatedSkillBar(
            skill: 'State Management',
            percentage: 0.95,
            color: Colors.green,
            description: 'Bloc, Provider, Riverpod',
          ),
          const SizedBox(height: 20),
          AnimatedSkillBar(
            skill: 'Backend Integration',
            percentage: 0.85,
            color: Colors.orange,
            description: 'REST APIs, GraphQL, Firebase',
          ),
          const SizedBox(height: 20),
          AnimatedSkillBar(
            skill: 'Testing & CI/CD',
            percentage: 0.80,
            color: Colors.red,
            description: 'Unit Testing, Integration Testing, GitHub Actions',
          ),
        ],
      ),
    );
  }
}
