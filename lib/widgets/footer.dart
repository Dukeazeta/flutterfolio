import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  final Function(int)? onSectionTap;
  
  const Footer({
    super.key,
    this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 30,
      ),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: ResponsiveUtils.getMaxContentWidth(context),
            ),
            child: isMobile
                ? Column(
                    children: [
                      _buildContactInfo(context),
                      const SizedBox(height: 40),
                      _buildQuickLinks(context),
                      const SizedBox(height: 40),
                      _buildSocialLinks(context),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildContactInfo(context)),
                      const SizedBox(width: 40),
                      Expanded(child: _buildQuickLinks(context)),
                      const SizedBox(width: 40),
                      Expanded(child: _buildSocialLinks(context)),
                    ],
                  ),
          ),
          const SizedBox(height: 60),
          Container(
            width: double.infinity,
            height: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' ${DateTime.now().year} Duke Azeta. All rights reserved.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '•',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  Text(
                    'Made with ',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  FlutterLogo(size: 16),
                  Text(
                    ' Flutter',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        _FooterLink(
          icon: Icons.email_outlined,
          text: 'dukeazeta@gmail.com',
          onTap: () => launchUrl(Uri.parse('mailto:dukeazeta@gmail.com')),
        ),
        const SizedBox(height: 12),
        _FooterLink(
          icon: Icons.phone_outlined,
          text: '+234 123 456 7890',
          onTap: () => launchUrl(Uri.parse('tel:+2341234567890')),
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    final quickLinks = [
      ('Home', 0),
      ('About', 1),
      ('Projects', 2),
      ('Contact', 3),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        ...quickLinks.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _FooterLink(
            text: link.$1,
            onTap: () => onSectionTap?.call(link.$2),
          ),
        )),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final socialLinks = [
      ('GitHub', 'assets/icons/github (1).svg', 'https://github.com/dukeazeta'),
      ('LinkedIn', 'assets/icons/linkedin-2.svg', 'https://linkedin.com/in/dukeazeta'),
      ('Twitter', 'assets/icons/twitter-x (3).svg', 'https://twitter.com/dukeazeta'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social Links',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: socialLinks.map((link) => Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _FooterSocialLink(
              svgPath: link.$2,
              tooltip: link.$1,
              onTap: () => launchUrl(Uri.parse(link.$3)),
            ),
          )).toList(),
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onTap;

  const _FooterLink({
    this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                size: 16,
                color: _isHovered
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white.withOpacity(0.7),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.text,
              style: TextStyle(
                color: _isHovered
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterSocialLink extends StatefulWidget {
  final String svgPath;
  final String tooltip;
  final VoidCallback onTap;

  const _FooterSocialLink({
    required this.svgPath,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_FooterSocialLink> createState() => _FooterSocialLinkState();
}

class _FooterSocialLinkState extends State<_FooterSocialLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isHovered 
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: SvgPicture.asset(
              widget.svgPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _isHovered
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white.withOpacity(0.7),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
