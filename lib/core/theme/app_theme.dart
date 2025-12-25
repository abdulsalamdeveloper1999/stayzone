import 'package:flutter/material.dart';

class AppTheme {
  // Design Constants - Shared radii and spacing
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Primary Colors - Deep, calming colors that promote focus
  static const Color primaryDark = Color(0xFF14111C); // Deep dark purple/navy
  static const Color primaryLight = Color(0xFF1A1625); // Slightly lighter
  static const Color accentColor = Color(0xFF231F33); // Surface/Card color
  static const Color highlightColor = Color(
    0xFF8B3DFF,
  ); // Vibrant purple accent

  // Surface Colors - Dark backgrounds
  static const Color surfaceDark = Color(0xFF0F0E17); // Almost black
  static const Color surfaceLight = Color(0xFF1A1625); // Card surface
  static const Color cardColor = Color(0xFF1D1B26); // Default card

  // Deep Black Theme Colors - Aligned with screenshots
  static const Color blackPrimaryDark = Color(0xFF0D0C14); // Very dark purple
  static const Color blackPrimaryLight = Color(0xFF14111C); // Dark purple
  static const Color blackAccentColor = Color(0xFF1D1B26); // Card/Input color

  // Premium Primary Color - Vibrant Purple from screenshots
  static const Color blackHighlightColor = Color(0xFF8B3DFF);

  static const Color blackSurfaceDark = Color(0xFF0D0C14); // Main background
  static const Color blackSurfaceLight = Color(0xFF14111C); // Surface
  static const Color blackCardColor = Color(0xFF1D1B26); // Card background

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF); // White
  static const Color textSecondary = Color(0xFF9E9E9E); // Gray
  static const Color textTertiary = Color(0xFF616161); // Darker gray

  // Status Colors - Subtle, muted for dark mode (toned down from Material defaults)
  static const Color successColor = Color(0xFF4CAF50); // Soft green
  static const Color warningColor = Color(0xFFFFB74D); // Soft orange
  static const Color errorColor = Color(0xFFE57373); // Soft red
  static const Color infoColor = Color(0xFF64B5F6); // Soft blue
  static const Color blockedColor = Color(
    0xFF6366F1,
  ); // Indigo/Purple for blocked
  static const Color streakColor = Color(0xFFF59E0B); // Amber for streak
  static const Color distractedColor = Color(0xFFE11D48); // Rose for distracted

  // Focus Timer Colors
  static const Color timerActive = Color(0xFF8B3DFF); // Vibrant purple
  static const Color timerPaused = Color(0xFF616161); // Gray
  static const Color timerBreak = Color(0xFF4CAF50); // Green

  // Font Family
  static const String fontFamily = 'Poppins';

  static ThemeData get darkTheme {
    final colorScheme = const ColorScheme.dark(
      primary: highlightColor,
      secondary: accentColor,
      tertiary: timerBreak,
      surface: surfaceLight,
      background: surfaceDark,
      error: errorColor,
      onPrimary: textPrimary,
      onSecondary: textPrimary,
      onSurface: textPrimary,
      onBackground: textPrimary,
      onError: textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      colorScheme: colorScheme,

      // Scaffold
      scaffoldBackgroundColor: colorScheme.background,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),

      // Card
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),

      // Text Theme - Using Poppins font family
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        displayMedium: const TextStyle(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        displaySmall: const TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        headlineLarge: const TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        headlineMedium: const TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        headlineSmall: const TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        titleLarge: const TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        titleMedium: const TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        titleSmall: const TextStyle(
          color: textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        bodyLarge: const TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontFamily: fontFamily,
        ),
        bodyMedium: const TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontFamily: fontFamily,
        ),
        bodySmall: const TextStyle(
          color: textSecondary,
          fontSize: 12,
          fontFamily: fontFamily,
        ),
        labelLarge: const TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        labelMedium: const TextStyle(
          color: textSecondary,
          fontSize: 12,
          fontFamily: fontFamily,
        ),
        labelSmall: const TextStyle(
          color: textTertiary,
          fontSize: 10,
          fontFamily: fontFamily,
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: accentColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: accentColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: highlightColor, width: 2),
        ),
        labelStyle: const TextStyle(
          color: textSecondary,
          fontFamily: fontFamily,
        ),
        hintStyle: const TextStyle(color: textTertiary, fontFamily: fontFamily),
      ),

      // Button Themes - Using colorScheme for consistency
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 4,
          shadowColor: colorScheme.primary.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingLarge,
            vertical: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ), // Pill shaped like screenshot
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingLarge,
            vertical: paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: textPrimary, size: 24),

      // Divider
      dividerTheme: const DividerThemeData(
        color: accentColor,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceLight,
        selectedItemColor: highlightColor,
        unselectedItemColor: textTertiary,
        elevation: 0, // Flat design
        type: BottomNavigationBarType.fixed,
      ),

      // Floating Action Button - Using colorScheme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        titleTextStyle: const TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        contentTextStyle: const TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontFamily: fontFamily,
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cardColor,
        contentTextStyle: const TextStyle(
          color: textPrimary,
          fontFamily: fontFamily,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Progress Indicator - Using colorScheme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),
    );
  }

  // Deep Black Theme - Pure black background for maximum focus
  static ThemeData get deepBlackTheme {
    final colorScheme = const ColorScheme.dark(
      primary: blackHighlightColor,
      secondary: blackAccentColor,
      tertiary: timerBreak,
      surface: blackSurfaceLight,
      background: blackSurfaceDark,
      error: errorColor,
      onPrimary: textPrimary,
      onSecondary: textPrimary,
      onSurface: textPrimary,
      onBackground: textPrimary,
      onError: textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      colorScheme: colorScheme,

      // Scaffold
      scaffoldBackgroundColor: colorScheme.background,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),

      // Card
      cardTheme: CardThemeData(
        color: blackCardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),

      // Text Theme - Using Poppins font family
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        displayMedium: const TextStyle(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        displaySmall: const TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        headlineLarge: const TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        headlineMedium: const TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        headlineSmall: const TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        titleLarge: const TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        titleMedium: const TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        titleSmall: const TextStyle(
          color: textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        bodyLarge: const TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontFamily: fontFamily,
        ),
        bodyMedium: const TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontFamily: fontFamily,
        ),
        bodySmall: const TextStyle(
          color: textSecondary,
          fontSize: 12,
          fontFamily: fontFamily,
        ),
        labelLarge: const TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        labelMedium: const TextStyle(
          color: textSecondary,
          fontSize: 12,
          fontFamily: fontFamily,
        ),
        labelSmall: const TextStyle(
          color: textTertiary,
          fontSize: 10,
          fontFamily: fontFamily,
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: blackCardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: blackAccentColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: blackAccentColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: blackHighlightColor, width: 2),
        ),
        labelStyle: const TextStyle(
          color: textSecondary,
          fontFamily: fontFamily,
        ),
        hintStyle: const TextStyle(color: textTertiary, fontFamily: fontFamily),
      ),

      // Button Themes - Fixed for white buttons (black text on white)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: blackHighlightColor, // Vibrant White/Purple
          foregroundColor: textPrimary,
          elevation: 8,
          shadowColor: blackHighlightColor.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingLarge,
            vertical: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ), // Pill shaped like screenshot
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: blackHighlightColor, // White text
          side: BorderSide(
            color: blackHighlightColor,
            width: 1.5,
          ), // White border
          padding: const EdgeInsets.symmetric(
            horizontal: paddingLarge,
            vertical: paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            color: blackHighlightColor, // White text
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: blackHighlightColor, // White text
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            color: blackHighlightColor, // White text
          ),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: textPrimary, size: 24),

      // Divider
      dividerTheme: const DividerThemeData(
        color: blackAccentColor,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation Bar - Matching image aesthetic (monochrome)
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: blackSurfaceDark, // Pure black like image
        selectedItemColor: textPrimary, // White for selected (matches image)
        unselectedItemColor:
            textTertiary, // Gray for unselected (matches image)
        elevation: 0, // No elevation for flat look
        type: BottomNavigationBarType.fixed,
      ),

      // Floating Action Button - White button with black icon
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: blackHighlightColor, // White
        foregroundColor: blackSurfaceDark, // Black icon
        elevation: 4,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: blackCardColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        titleTextStyle: const TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        contentTextStyle: const TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontFamily: fontFamily,
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: blackCardColor,
        contentTextStyle: const TextStyle(
          color: textPrimary,
          fontFamily: fontFamily,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Progress Indicator - Using colorScheme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),
    );
  }

  // Optional: Light theme for users who prefer it (but dark is default)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      // Light theme can be added later if needed
      // For now, focus app should use dark theme
    );
  }
}
