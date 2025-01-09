import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

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
          if (!isMobile)
            Container(
              constraints: BoxConstraints(
                maxWidth: ResponsiveUtils.getMaxContentWidth(context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildContactInfo(context)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildQuickLinks(context)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildSocialLinks(context)),
                ],
              ),
            )
          else
            Column(
              children: [
                _buildContactInfo(context),
                const SizedBox(height: 40),
                _buildQuickLinks(context),
                const SizedBox(height: 40),
                _buildSocialLinks(context),
              ],
            ),
          const SizedBox(height: 60),
          Container(
            width: double.infinity,
            height: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          const SizedBox(height: 30),
          Text(
            ' ${DateTime.now().year} Duke Azeta. All rights reserved.',
            style: Theme.of(context).textTheme.bodyMedium,
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
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          context,
          icon: Icons.email,
          text: 'hello@dukeazeta.dev',
          onTap: () => _launchUrl('mailto:hello@dukeazeta.dev'),
        ),
        const SizedBox(height: 10),
        _buildContactItem(
          context,
          icon: Icons.phone,
          text: '+234 123 456 7890',
          onTap: () => _launchUrl('tel:+2341234567890'),
        ),
        const SizedBox(height: 10),
        _buildContactItem(
          context,
          icon: Icons.location_on,
          text: 'Lagos, Nigeria',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        _buildFooterLink(context, 'Home', () {}),
        const SizedBox(height: 10),
        _buildFooterLink(context, 'About', () {}),
        const SizedBox(height: 10),
        _buildFooterLink(context, 'Projects', () {}),
        const SizedBox(height: 10),
        _buildFooterLink(context, 'Contact', () {}),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social Links',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSocialIcon(
              context,
              'assets/icons/github.png',
              () => _launchUrl('https://github.com/dukeazeta'),
            ),
            const SizedBox(width: 20),
            _buildSocialIcon(
              context,
              'assets/icons/linkedin.png',
              () => _launchUrl('https://linkedin.com/in/dukeazeta'),
            ),
            const SizedBox(width: 20),
            _buildSocialIcon(
              context,
              'assets/icons/twitter.png',
              () => _launchUrl('https://twitter.com/dukeazeta'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(
    BuildContext context,
    String text,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildSocialIcon(
    BuildContext context,
    String iconPath,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: Image.asset(
          iconPath,
          width: 24,
          height: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
