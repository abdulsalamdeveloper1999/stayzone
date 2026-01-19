import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';

@RoutePage()
class WelcomeOnboardingPage extends StatefulWidget {
  const WelcomeOnboardingPage({super.key});

  @override
  State<WelcomeOnboardingPage> createState() => _WelcomeOnboardingPageState();
}

class _WelcomeOnboardingPageState extends State<WelcomeOnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Animations
  late final AnimationController _breathingController;
  late final Animation<double> _breathingAnimation;

  @override
  void initState() {
    super.initState();
    // Slow breathing animation for background
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _breathingController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blackSurfaceDark,
      body: Stack(
        children: [
          // Mind-bending background animation
          AnimatedBuilder(
            animation: _breathingController,
            builder: (context, child) {
              final rotation = _breathingController.value * 2 * 3.14159;
              return Stack(
                children: [
                  // Rotating outer ring
                  Center(
                    child: Transform.rotate(
                      angle: rotation,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1.2,
                        height: MediaQuery.of(context).size.width * 1.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              AppTheme.highlightColor.withValues(alpha: 0.1),
                              Colors.purple.withValues(alpha: 0.05),
                              AppTheme.highlightColor.withValues(alpha: 0.15),
                              Colors.pink.withValues(alpha: 0.05),
                              AppTheme.highlightColor.withValues(alpha: 0.1),
                            ],
                            stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Counter-rotating middle layer
                  Center(
                    child: Transform.rotate(
                      angle: -rotation * 1.5,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              Colors.indigo.withValues(alpha: 0.1),
                              AppTheme.highlightColor.withValues(alpha: 0.2),
                              Colors.indigo.withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Pulsing core
                  Center(
                    child: Container(
                      width:
                          MediaQuery.of(context).size.width *
                          0.5 *
                          _breathingAnimation.value,
                      height:
                          MediaQuery.of(context).size.width *
                          0.5 *
                          _breathingAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.highlightColor.withValues(alpha: 0.25),
                            AppTheme.highlightColor.withValues(alpha: 0.05),
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.highlightColor.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 80 * _breathingAnimation.value,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Floating particles
                  ...List.generate(18, (index) {
                    final isReverse = index % 2 == 1;
                    final direction = isReverse ? -1.0 : 1.0;
                    final speedMultiplier = 15.0 + (index % 4) * 5;
                    final angle =
                        (index * 20.0 +
                            rotation * speedMultiplier * direction) *
                        3.14159 /
                        180;
                    final orbitLayer = index % 3;
                    final radius = 100.0 + orbitLayer * 50.0;
                    final size = 3.0 + orbitLayer * 1.5;
                    final alpha = 0.4 - (orbitLayer * 0.1);

                    return Positioned(
                      left:
                          MediaQuery.of(context).size.width / 2 +
                          radius * cos(angle),
                      top:
                          MediaQuery.of(context).size.height / 2 +
                          radius * sin(angle),
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.highlightColor.withValues(
                            alpha: alpha,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.highlightColor.withValues(
                                alpha: alpha * 0.8,
                              ),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Page Indicator
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppTheme.highlightColor
                              : Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),

                // Swipeable content
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    children: [
                      _buildScreen1Promise(),
                      _buildScreen2HowItWorks(),
                      _buildScreen3GetStarted(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreen1Promise() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Emoji Icon
          const Text('🎯', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 32),
          Text(
            'The app that brings\nyou back when you\nget distracted.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTheme.fontFamily,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Your digital focus companion',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
              fontFamily: AppTheme.fontFamily,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            child: Text(
              'Swipe to learn more →',
              style: TextStyle(color: AppTheme.highlightColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreen2HowItWorks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text('⏱️', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 32),
          Text(
            'Focus Sessions\nUrge Tracking\nMindful Breaks',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTheme.fontFamily,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          _buildFeatureRow('🔒', 'Block distractions automatically'),
          const SizedBox(height: 12),
          _buildFeatureRow('📊', 'Track your progress daily'),
          const SizedBox(height: 12),
          _buildFeatureRow('🎵', 'Focus with calming sounds'),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildScreen3GetStarted() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text('🧘‍♂️', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 32),
          Text(
            'Join the\nMonk Squad',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTheme.fontFamily,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Thousands of users building focus\nevery single day',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
              fontFamily: AppTheme.fontFamily,
              height: 1.5,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _finishWelcome,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.highlightColor,
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: AppTheme.highlightColor.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String emoji, String text) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.9),
              fontFamily: AppTheme.fontFamily,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _finishWelcome() async {
    final prefs = getIt<SharedPreferences>();
    await prefs.setBool('welcome_seen', true);

    if (mounted) {
      context.router.replaceAll([const SignUpRoute()]);
    }
  }
}
