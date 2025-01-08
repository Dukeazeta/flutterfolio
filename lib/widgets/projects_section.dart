import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          Text(
            'My Projects',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              _ProjectCard(
                title: 'Project 1',
                description: 'A Flutter mobile app for e-commerce',
                technologies: ['Flutter', 'Firebase', 'Provider'],
                imageUrl: 'assets/project1.png',
              ),
              _ProjectCard(
                title: 'Project 2',
                description: 'A cross-platform social media app',
                technologies: ['Flutter', 'REST API', 'Bloc'],
                imageUrl: 'assets/project2.png',
              ),
              _ProjectCard(
                title: 'Project 3',
                description: 'A Flutter web dashboard',
                technologies: ['Flutter Web', 'Charts', 'GetX'],
                imageUrl: 'assets/project3.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> technologies;
  final String imageUrl;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.technologies,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text('Project Image'), // TODO: Replace with actual image
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: technologies.map((tech) => Chip(label: Text(tech))).toList(),
          ),
        ],
      ),
    );
  }
}
