import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
import 'common/gradient_text.dart';
import 'dart:math' as math';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context),
      constraints: BoxConstraints(
        maxWidth: ResponsiveUtils.getMaxContentWidth(context),
      ),
      child: Column(
        children: [
          const SizedBox(height: 100),
          GradientText(
            'Featured Projects',
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 50),
          const ProjectsGrid(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class ProjectsGrid extends StatelessWidget {
  const ProjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = isMobile ? 1 : (isDesktop ? 3 : 2);
        final itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 20) / crossAxisCount;
        final itemHeight = itemWidth * (isMobile ? 0.8 : 0.9);

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: projects.map((project) => SizedBox(
            width: itemWidth,
            height: itemHeight,
            child: AnimatedProjectCard(project: project),
          )).toList(),
        );
      },
    );
  }
}

class AnimatedProjectCard extends StatefulWidget {
  final Project project;

  const AnimatedProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<AnimatedProjectCard> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 0.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void launchProjectLinks(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.project.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => launchUrl(Uri.parse(widget.project.projectUrl)),
              child: const Text('Visit Demo'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => launchUrl(Uri.parse(widget.project.githubUrl)),
              child: const Text('View Code'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_rotationAnimation.value)
              ..scale(_scaleAnimation.value),
            alignment: Alignment.center,
            child: child,
          );
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => launchProjectLinks(context),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    blurRadius: isHovered ? 20 : 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.project.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(isHovered ? 0.9 : 0.7),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.project.title,
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: isHovered ? 60 : 0,
                            child: SingleChildScrollView(
                              child: Text(
                                widget.project.description,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: widget.project.technologies.map((tech) => 
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        tech,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ).toList(),
                                ),
                              ),
                              if (isHovered) ...[
                                const SizedBox(width: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.link, color: Colors.white),
                                      onPressed: () => launchUrl(Uri.parse(widget.project.projectUrl)),
                                      tooltip: 'Visit Demo',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.code, color: Colors.white),
                                      onPressed: () => launchUrl(Uri.parse(widget.project.githubUrl)),
                                      tooltip: 'View Code',
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String projectUrl;
  final String githubUrl;

  const Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.projectUrl,
    required this.githubUrl,
  });
}

final List<Project> projects = [
  Project(
    title: 'E-Commerce App',
    description: 'A full-featured e-commerce application built with Flutter and Firebase. Features include real-time product updates, secure payments with Stripe, and a beautiful UI.',
    imageUrl: 'https://images.unsplash.com/photo-1472851294608-062f824d29cc',
    technologies: ['Flutter', 'Firebase', 'Stripe'],
    projectUrl: 'https://ecommerce-demo.dukeazeta.dev',
    githubUrl: 'https://github.com/dukeazeta/flutter-ecommerce',
  ),
  Project(
    title: 'Social Media Dashboard',
    description: 'A responsive social media analytics dashboard with real-time data visualization using Charts and REST APIs.',
    imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f',
    technologies: ['Flutter', 'REST API', 'Charts'],
    projectUrl: 'https://dashboard-demo.dukeazeta.dev',
    githubUrl: 'https://github.com/dukeazeta/social-dashboard',
  ),
  Project(
    title: 'Task Management',
    description: 'A beautiful and intuitive task management app with local storage and state management using Provider.',
    imageUrl: 'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b',
    technologies: ['Flutter', 'SQLite', 'Provider'],
    projectUrl: 'https://tasks-demo.dukeazeta.dev',
    githubUrl: 'https://github.com/dukeazeta/task-manager',
  ),
  Project(
    title: 'Weather App',
    description: 'A weather application with beautiful animations and real-time weather updates using a Weather API.',
    imageUrl: 'https://images.unsplash.com/photo-1592210454359-9043f067919b',
    technologies: ['Flutter', 'Weather API', 'Animations'],
    projectUrl: 'https://weather-demo.dukeazeta.dev',
    githubUrl: 'https://github.com/dukeazeta/weather-app',
  ),
  Project(
    title: 'Fitness Tracker',
    description: 'A comprehensive fitness tracking application integrated with HealthKit for iOS and Google Fit for Android.',
    imageUrl: 'https://images.unsplash.com/photo-1476480862126-209bfaa8edc8',
    technologies: ['Flutter', 'HealthKit', 'BLoC'],
    projectUrl: 'https://fitness-demo.dukeazeta.dev',
    githubUrl: 'https://github.com/dukeazeta/fitness-tracker',
  ),
  Project(
    title: 'Music Player',
    description: 'A modern music player with a sleek design, audio visualizations, and support for multiple audio formats.',
    imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4',
    technologies: ['Flutter', 'Audio Player', 'Riverpod'],
    projectUrl: 'https://music-demo.dukeazeta.dev',
    githubUrl: 'https://github.com/dukeazeta/music-player',
  ),
];
