import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Animations
  late final AnimationController _breathingController;
  late final Animation<double> _breathingAnimation;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  // Data
  final Set<String> _distractions = {};
  double _strictness = 1.0; // 0: Gentle, 1: Strict, 2: Monk
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);

  @override
  void initState() {
    super.initState();
    // Breathing animation (very slow, hypnotic pulse)
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

    // Fade in content
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _fadeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blackSurfaceDark,
      body: Stack(
        children: [
          // Mind-bending geometric patterns
          AnimatedBuilder(
            animation: _breathingController,
            builder: (context, child) {
              final rotation = _breathingController.value * 2 * 3.14159;
              return Stack(
                children: [
                  // Layer 1: Rotating outer ring
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

                  // Layer 2: Counter-rotating middle layer
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

                  // Layer 3: Pulsing core
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

                  // Floating particles - alternating forward/reverse orbits
                  ...List.generate(18, (index) {
                    // Alternate direction: even indices go forward, odd go reverse
                    final isReverse = index % 2 == 1;
                    final direction = isReverse ? -1.0 : 1.0;

                    // Slower rotation speed for smooth black hole effect
                    final speedMultiplier = 15.0 + (index % 4) * 5;
                    final angle =
                        (index * 20.0 +
                            rotation * speedMultiplier * direction) *
                        3.14159 /
                        180;

                    // Multiple orbital radii for depth effect
                    final orbitLayer = index % 3;
                    final radius = 100.0 + orbitLayer * 50.0;

                    // Size variation based on orbit
                    final size = 3.0 + orbitLayer * 1.5;

                    // Opacity variation - inner orbits brighter
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

          // Content with Fade Entry
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Progress Bar
                  LinearProgressIndicator(
                    value: (_currentPage + 1) / 3,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    color: AppTheme.highlightColor,
                    minHeight: 4,
                  ),

                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                        _fadeController.reset();
                        _fadeController.forward();
                      },
                      children: [
                        _buildStep1Promise(),
                        _buildStep2Strictness(),
                        _buildStep3Schedule(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1Promise() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'The app that brings\nyou back when you\nget distracted.',
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
            'What distracts you most?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
              fontFamily: AppTheme.fontFamily,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                [
                  'Instagram',
                  'TikTok',
                  'X / Twitter',
                  'YouTube',
                  'Games',
                  'News',
                  'Everything',
                ].map((d) {
                  final isSelected = _distractions.contains(d);
                  return FilterChip(
                    label: Text(d),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _distractions.add(d);
                        } else {
                          _distractions.remove(d);
                        }
                      });
                    },
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    selectedColor: AppTheme.highlightColor.withValues(
                      alpha: 0.3,
                    ),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppTheme.highlightColor
                          : Colors.white,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.highlightColor
                            : Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    checkmarkColor: AppTheme.highlightColor,
                  );
                }).toList(),
          ),
          const Spacer(),
          _buildNextButton(
            onPressed: _distractions.isNotEmpty ? () => _nextPage() : null,
            label: 'Next',
          ),
        ],
      ),
    );
  }

  Widget _buildStep2Strictness() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'How strict should I be?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTheme.fontFamily,
            ),
          ),
          const SizedBox(height: 40),

          _buildStrictnessOption(
            value: 0.0,
            title: 'Gentle',
            desc: 'I\'ll nudge you when you drift.',
            icon: Icons.notifications_active_outlined,
          ),
          const SizedBox(height: 16),
          _buildStrictnessOption(
            value: 1.0,
            title: 'Strict',
            desc: 'I\'ll block distractions immediately.',
            icon: Icons.block_outlined,
          ),
          const SizedBox(height: 16),
          _buildStrictnessOption(
            value: 2.0,
            title: 'Monk Mode',
            desc: 'No mercy. Hard lock.',
            icon: Icons.lock_outline,
          ),

          const Spacer(),
          _buildNextButton(onPressed: () => _nextPage(), label: 'Next'),
        ],
      ),
    );
  }

  Widget _buildStrictnessOption({
    required double value,
    required String title,
    required String desc,
    required IconData icon,
  }) {
    final isSelected = _strictness == value;
    return GestureDetector(
      onTap: () => setState(() => _strictness = value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.highlightColor.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.highlightColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? AppTheme.highlightColor : Colors.grey[400],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.highlightColor),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3Schedule() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'When do you\nusually work?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTheme.fontFamily,
            ),
          ),
          const SizedBox(height: 40),

          // Time Pickers (Simplified)
          Row(
            children: [
              Expanded(
                child: _buildTimeCard(
                  'Start',
                  _startTime,
                  (t) => setState(() => _startTime = t),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTimeCard(
                  'End',
                  _endTime,
                  (t) => setState(() => _endTime = t),
                ),
              ),
            ],
          ),

          const Spacer(),
          _buildNextButton(
            onPressed: _finishOnboarding,
            label: 'Start First Session',
            isPrimary: true,
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: _finishOnboarding,
              child: Text(
                'Skip specific setup',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(
    String label,
    TimeOfDay time,
    Function(TimeOfDay) onChanged,
  ) {
    // Note: For MVP speed, we'll just show text. In real implementation, this would open showTimePicker
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: time,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
                  primary: AppTheme.highlightColor,
                  onPrimary: Colors.white,
                  surface: AppTheme.blackCardColor,
                  onSurface: Colors.white,
                  secondary: AppTheme.highlightColor,
                  onSecondary: Colors.white,
                ),
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: AppTheme.blackCardColor,
                  hourMinuteColor: AppTheme.highlightColor,
                  hourMinuteTextColor: Colors.white,
                  dayPeriodColor: AppTheme.highlightColor,
                  dayPeriodTextColor: Colors.white,
                  dialBackgroundColor: AppTheme.blackAccentColor,
                  dialHandColor: AppTheme.highlightColor,
                  dialTextColor: Colors.white,
                  entryModeIconColor: AppTheme.highlightColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) onChanged(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(label, style: TextStyle(color: Colors.grey[400])),
            const SizedBox(height: 8),
            Text(
              time.format(context),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton({
    required VoidCallback? onPressed,
    required String label,
    bool isPrimary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed == null
              ? Colors.white.withValues(alpha: 0.1)
              : (isPrimary ? AppTheme.highlightColor : Colors.white),
          foregroundColor: isPrimary ? Colors.white : AppTheme.blackPrimaryDark,
          elevation: isPrimary ? 8 : 0,
          shadowColor: isPrimary
              ? AppTheme.highlightColor.withValues(alpha: 0.5)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finishOnboarding() async {
    // Save state
    final prefs = getIt<SharedPreferences>();
    await prefs.setBool('onboarding_seen', true);

    // Check auth status here or simple push
    // For now, push to Auth Choice so they can login/signup or continue as guest
    if (mounted) {
      // Use router.replaceAll to clear stack
      context.router.replaceAll([const LoginRoute()]);
      // Note: Ideally if they skip login, we'd go to Home, but user flow says auth first usually.
      // If we want Guest access, Login page should have "Continue as Guest"
    }
  }
}
