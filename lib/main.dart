import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'widgets/grid_background.dart';
import 'widgets/common/particle_background.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duke Azeta - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF00DEB5),
          secondary: const Color(0xFF9C27B0),
          surface: const Color(0xFF1A1A1A),
          background: const Color(0xFF0A0A0A),
        ),
        textTheme: GoogleFonts.spaceGroteskTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: Stack(
        children: [
          const GridBackground(
            child: ParticleBackground(
              numberOfParticles: 30,
              particleColor: Color(0xFF00DEB5),
            ),
          ),
          const HomeScreen(),
        ],
      ),
    );
  }
}