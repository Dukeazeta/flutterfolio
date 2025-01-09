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
              childAspectRatio: isMobile ? 1.2 : 1.1,
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
    description: 'A full-featured e-commerce application built with Flutter and Firebase.',
    imageUrl: 'https://picsum.photos/500/300',
    technologies: ['Flutter', 'Firebase', 'Stripe'],
  ),
  Project(
    title: 'Social Media Dashboard',
    description: 'A responsive social media analytics dashboard with real-time data visualization.',
    imageUrl: 'https://picsum.photos/500/301',
    technologies: ['Flutter', 'REST API', 'Charts'],
  ),
  Project(
    title: 'Task Management',
    description: 'A beautiful and intuitive task management app with cloud sync.',
    imageUrl: 'https://picsum.photos/500/302',
    technologies: ['Flutter', 'SQLite', 'Provider'],
  ),
  Project(
    title: 'Weather App',
    description: 'A weather application with beautiful animations and accurate forecasts.',
    imageUrl: 'https://picsum.photos/500/303',
    technologies: ['Flutter', 'Weather API', 'Animations'],
  ),
  Project(
    title: 'Fitness Tracker',
    description: 'A comprehensive fitness tracking application with workout plans.',
    imageUrl: 'https://picsum.photos/500/304',
    technologies: ['Flutter', 'HealthKit', 'BLoC'],
  ),
  Project(
    title: 'Music Player',
    description: 'A modern music player with a beautiful UI, supporting various audio formats.',
    imageUrl: 'https://picsum.photos/500/305',
    technologies: ['Flutter', 'Audio Player', 'Riverpod'],
  ),
];

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
        transform: Matrix4.identity()..translate(0.0, isHovered ? -10.0 : 0.0, 0.0),
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
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  widget.project.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.project.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 32,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: widget.project.technologies.map((tech) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                tech,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
