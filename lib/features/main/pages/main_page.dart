import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../home/pages/home_page.dart';
import '../../heatmap/pages/heatmap_page.dart';
import '../../sessions/pages/sessions_page.dart';
import '../../settings/pages/settings_page.dart';
import '../../home/presentation/cubit/home_cubit.dart';
import '../../home/presentation/cubit/home_state.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const HeatmapPage(),
    const SessionsPage(),
    const SettingsPage(),
  ];

  final List<_NavItem> _navItems = [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home),
    _NavItem(icon: Icons.bar_chart_outlined, activeIcon: Icons.bar_chart),
    _NavItem(icon: Icons.history_outlined, activeIcon: Icons.history),
    _NavItem(icon: Icons.person_outline, activeIcon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Pages
              IndexedStack(index: _selectedIndex, children: _pages),

              // Floating Navbar
              if (!((state.isRunning || state.isPaused) && _selectedIndex == 0))
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.blackCardColor.withValues(alpha: 0.8),
                                AppTheme.blackCardColor.withValues(alpha: 0.6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(_navItems.length, (
                                index,
                              ) {
                                final isActive = _selectedIndex == index;
                                final item = _navItems[index];

                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _selectedIndex = index),
                                    behavior: HitTestBehavior.opaque,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            curve: Curves.easeOutCubic,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: isActive
                                                  ? AppTheme.highlightColor
                                                        .withValues(alpha: 0.15)
                                                  : Colors.transparent,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              isActive
                                                  ? item.activeIcon
                                                  : item.icon,
                                              color: isActive
                                                  ? AppTheme.highlightColor
                                                  : Colors.white.withValues(
                                                      alpha: 0.5,
                                                    ),
                                              size: 24,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            width: isActive ? 6 : 0,
                                            height: isActive ? 6 : 0,
                                            decoration: BoxDecoration(
                                              color: AppTheme.highlightColor,
                                              shape: BoxShape.circle,
                                              boxShadow: isActive
                                                  ? [
                                                      BoxShadow(
                                                        color: AppTheme
                                                            .highlightColor
                                                            .withValues(
                                                              alpha: 0.5,
                                                            ),
                                                        blurRadius: 8,
                                                        spreadRadius: 1,
                                                      ),
                                                    ]
                                                  : [],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;

  _NavItem({required this.icon, required this.activeIcon});
}
