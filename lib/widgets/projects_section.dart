import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
import 'common/gradient_text.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
            'My Projects',
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isDesktop ? 3 : 2),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: isMobile ? 1.2 : 0.8,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index]);
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -10.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                widget.project.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.project.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.technologies
                        .map((tech) => Chip(
                              label: Text(tech),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
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

  const Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
  });
}

final List<Project> projects = [
  Project(
    title: 'E-Commerce App',
    description:
        'A full-featured e-commerce application built with Flutter and Firebase, featuring real-time updates and seamless payment integration.',
    imageUrl: 'https://picsum.photos/800/600?random=1',
    technologies: ['Flutter', 'Firebase', 'Stripe'],
  ),
  Project(
    title: 'Social Media Dashboard',
    description:
        'A responsive social media analytics dashboard with real-time data visualization and custom animations.',
    imageUrl: 'https://picsum.photos/800/600?random=2',
    technologies: ['Flutter', 'REST API', 'Charts'],
  ),
  Project(
    title: 'Task Management',
    description:
        'A beautiful and intuitive task management app with cloud sync and team collaboration features.',
    imageUrl: 'https://picsum.photos/800/600?random=3',
    technologies: ['Flutter', 'SQLite', 'Provider'],
  ),
  Project(
    title: 'Weather App',
    description:
        'A weather application with beautiful animations and accurate forecasts using modern weather APIs.',
    imageUrl: 'https://picsum.photos/800/600?random=4',
    technologies: ['Flutter', 'Weather API', 'Animations'],
  ),
  Project(
    title: 'Fitness Tracker',
    description:
        'A comprehensive fitness tracking application with workout plans, progress tracking, and social features.',
    imageUrl: 'https://picsum.photos/800/600?random=5',
    technologies: ['Flutter', 'HealthKit', 'BLoC'],
  ),
  Project(
    title: 'Music Player',
    description:
        'A modern music player with a beautiful UI, supporting various audio formats and playlist management.',
    imageUrl: 'https://picsum.photos/800/600?random=6',
    technologies: ['Flutter', 'Audio Player', 'Riverpod'],
  ),
];
