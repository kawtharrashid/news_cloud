import 'package:flutter/material.dart';
import 'package:news_cloud/core/config/theme_data/app_colors.dart';
import 'package:news_cloud/core/constants.dart';

abstract class GlobalTheme {
  GlobalTheme._();

  // AppBar
  static const AppBarTheme appBarTheme = AppBarTheme(
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      fontFamily: roboto,
    ),
    iconTheme: IconThemeData(
      size: 24,
    ),
  );

  // Icon buttons
  static IconButtonThemeData get iconButtonTheme {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.grey,
        iconSize: 20,
        padding: const EdgeInsets.all(8),
        minimumSize: const Size(40, 40),
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
    );
  }

  // Input fields
  static const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    isDense: true,
    filled: true,
    alignLabelWithHint: true,
    hintStyle: TextStyle(
      fontSize: 12,
      fontFamily: roboto,
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
  );

  // Typography
  static const TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: roboto,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: roboto,
    ),
    headlineLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: roboto,
    ),
    headlineMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: roboto,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: roboto,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: roboto,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: roboto,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: roboto,
    ),
  );

  // General icons
  static const IconThemeData iconTheme = IconThemeData(
    size: 16,
  );

//switch
  static final SwitchThemeData switchThemeData = SwitchThemeData(
    trackOutlineColor: const WidgetStatePropertyAll(AppColors.transParent),
    trackOutlineWidth: const WidgetStatePropertyAll(0),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.lightBackground;
      }
      return AppColors.iconLight;
    }),
    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(
          Icons.circle,
          size: 24,
          color: AppColors.lightBackground,
        );
      }
      return const Icon(
        Icons.circle,
        size: 24,
        color: AppColors.iconLight,
      );
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.iconLight;
      }
      return AppColors.grey;
    }),
    splashRadius: 20,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    overlayColor: WidgetStatePropertyAll(
      AppColors.iconLight.withValues(alpha: 0.2),
    ),
  );

  // Popup menus
  static PopupMenuThemeData get popupMenuTheme {
    return PopupMenuThemeData(
      iconSize: 24,
      position: PopupMenuPosition.under,
      elevation: 6,
      menuPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontSize: 12,
        fontFamily: roboto,
        fontWeight: FontWeight.w200,
      ),
    );
  }
}
