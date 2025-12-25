import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/app_theme.dart';
import '../features/onboarding/pages/onboarding_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'StayZone',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.deepBlackTheme,
          // Deep black theme for maximum focus - pure black background
          darkTheme: AppTheme.deepBlackTheme,
          themeMode: ThemeMode.dark, // Force dark mode
          home: const OnboardingPage(),
        );
      },
    );
  }
}
