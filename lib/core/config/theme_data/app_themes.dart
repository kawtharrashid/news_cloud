import 'package:flutter/material.dart';
import 'package:news_cloud/core/constants.dart';
import 'app_colors.dart';
import 'global_theme.dart';

class AppThemes {
  static final ThemeData _base = globalTheme();

  static final ThemeData light = _base.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.appBarLight,
      surface: AppColors.lightSurface,
      onPrimary: Colors.black,
      onSurface: AppColors.lightTextPrimary,
    ),
    appBarTheme: _base.appBarTheme.copyWith(
      backgroundColor: AppColors.appBarLight,
      titleTextStyle: _base.appBarTheme.titleTextStyle?.copyWith(
        color: AppColors.iconLight,
      ),
      foregroundColor: AppColors.iconLight,
      iconTheme: _base.appBarTheme.iconTheme?.copyWith(
        color: AppColors.iconLight,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: roboto,
          shadows: [
            Shadow(
              color: AppColors.iconLight,
              offset: Offset(0.5, 1),
              blurRadius: 1,
            ),
          ],
        ),
      ),
    ),
    iconTheme: _base.iconTheme.copyWith(color: AppColors.iconLight),
    cardTheme: _base.cardTheme.copyWith(
      color: AppColors.lightSurface,
    ),
    textTheme: _base.textTheme.copyWith(
      titleLarge: _base.textTheme.titleLarge?.copyWith(
        color: AppColors.iconLight,
      ),
      titleMedium: _base.textTheme.titleMedium?.copyWith(
        color: AppColors.lightTextPrimary,
      ),
      labelSmall:
          _base.textTheme.labelSmall?.copyWith(color: AppColors.iconLight),
      headlineLarge: _base.textTheme.headlineLarge
          ?.copyWith(color: AppColors.lightTextPrimary),
      bodyLarge: _base.textTheme.bodyLarge?.copyWith(
        color: AppColors.lightTextPrimary,
      ),
      headlineMedium: _base.textTheme.headlineLarge
          ?.copyWith(color: AppColors.lightTextPrimary),
      bodyMedium: _base.textTheme.bodyMedium?.copyWith(
        color: AppColors.lightTextPrimary,
      ),
      bodySmall: _base.textTheme.bodySmall?.copyWith(
        color: AppColors.lightTextSecondary,
      ),
    ),
  );

  static final ThemeData dark = _base.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.appBarDark,
      surface: AppColors.darkSurface,
      onPrimary: Colors.black,
      onSurface: AppColors.darkTextPrimary,
    ),
    appBarTheme: _base.appBarTheme.copyWith(
      backgroundColor: AppColors.appBarDark,
      foregroundColor: AppColors.iconDark,
      iconTheme: _base.appBarTheme.iconTheme?.copyWith(
        color: AppColors.iconDark,
        // size: 24,
      ),
      titleTextStyle: _base.appBarTheme.titleTextStyle?.copyWith(
        color: AppColors.iconDark,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.iconDark,
          fontFamily: roboto,
          shadows: [
            Shadow(
              color: AppColors.iconDark,
              offset: Offset(0.5, 1),
              blurRadius: 1,
            ),
          ],
        ),
      ),
    ),
    iconTheme: _base.iconTheme.copyWith(color: AppColors.iconDark),
    cardTheme: _base.cardTheme.copyWith(
      color: AppColors.darkSurface,
    ),
    textTheme: _base.textTheme.copyWith(
      titleLarge: _base.textTheme.titleLarge?.copyWith(
        color: AppColors.iconDark,
      ),
      titleMedium: _base.textTheme.titleMedium?.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      labelSmall:
          _base.textTheme.labelSmall?.copyWith(color: AppColors.iconDark),
      headlineLarge: _base.textTheme.headlineLarge
          ?.copyWith(color: AppColors.darkTextPrimary),
      headlineMedium: _base.textTheme.headlineLarge
          ?.copyWith(color: AppColors.darkTextPrimary),
      bodyLarge: _base.textTheme.bodyLarge?.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      bodyMedium: _base.textTheme.bodyMedium?.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      bodySmall: _base.textTheme.bodySmall?.copyWith(
        color: AppColors.darkTextSecondary,
      ),
    ),
  );
}
