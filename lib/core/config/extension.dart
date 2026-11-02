import 'package:flutter/material.dart';
import 'package:news_cloud/core/config/theme_data/app_colors.dart';

extension ThemeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get shimmerBaseColor => isDarkMode
      ? AppColors.shimmerBaseColorDark
      : AppColors.shimmerBaseColorLight;

  Color get shimmerHighlightColor => isDarkMode
      ? AppColors.shimmerHighlightColorDark
      : AppColors.shimmerHighlightColorLight;
}
