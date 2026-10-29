import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'global_theme.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get light => _build(
        brightness: Brightness.light,
        scaffold: AppColors.lightBackground,
        surface: AppColors.lightSurface,
        appBar: AppColors.appBarLight,
        iconColor: AppColors.iconLight,
        textPrimary: AppColors.lightTextPrimary,
        textSecondary: AppColors.lightTextSecondary,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        scaffold: AppColors.darkBackground,
        surface: AppColors.darkSurface,
        appBar: AppColors.appBarDark,
        iconColor: AppColors.iconDark,
        textPrimary: AppColors.darkTextPrimary,
        textSecondary: AppColors.darkTextSecondary,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color scaffold,
    required Color surface,
    required Color appBar,
    required Color iconColor,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: brightness == Brightness.light
          ? AppColors.iconLight
          : AppColors.iconDark,
      onPrimary: brightness == Brightness.light
          ? Colors.white
          : AppColors.darkBackground,
      secondary: AppColors.secondTitle,
      onSecondary: Colors.black,
      error: AppColors.textErrorColor,
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
    );

    const baseTextTheme = GlobalTheme.textTheme;

    final textTheme = baseTextTheme.copyWith(
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        color: iconColor,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        color: textPrimary,
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        color: textPrimary,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        color: textPrimary,
      ),
      labelSmall: baseTextTheme.labelSmall?.copyWith(
        color: iconColor,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: textPrimary,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: textPrimary,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        color: textSecondary,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      scaffoldBackgroundColor: scaffold,

      // Typography
      textTheme: textTheme,

      // App bar
      appBarTheme: GlobalTheme.appBarTheme.copyWith(
        backgroundColor: appBar,
        foregroundColor: iconColor,
        titleTextStyle: GlobalTheme.appBarTheme.titleTextStyle?.copyWith(
          color: iconColor,
        ),
        iconTheme: GlobalTheme.appBarTheme.iconTheme?.copyWith(
          color: iconColor,
        ),
      ),

      // Icon buttons
      iconButtonTheme: GlobalTheme.iconButtonTheme,

      // General icons
      iconTheme: GlobalTheme.iconTheme.copyWith(
        color: iconColor,
      ),
      switchTheme: GlobalTheme.switchThemeData,
      inputDecorationTheme: GlobalTheme.inputDecorationTheme.copyWith(
        iconColor: iconColor,
        prefixIconColor: iconColor,
        suffixIconColor: iconColor,
        fillColor: appBar,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(
            color: iconColor,
            width: 1.2,
          ),
        ),
      ),

      // Text buttons
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: iconColor,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft,
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            shadows: [
              Shadow(
                color: iconColor,
                offset: const Offset(0.5, 1),
                blurRadius: 1,
              ),
            ],
          ),
        ),
      ),

      // Popup menus
      popupMenuTheme: GlobalTheme.popupMenuTheme.copyWith(
        color: scaffold,
        shadowColor: iconColor,
        surfaceTintColor: appBar,
        textStyle: GlobalTheme.popupMenuTheme.textStyle?.copyWith(
          color: textPrimary,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: surface,
      ),
    );
  }
}
