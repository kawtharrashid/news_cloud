import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);
  static const String isDarkTheme = 'isDarkTheme';

  Future<void> changeTheme() async {
    final newTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isDarkTheme, newTheme == ThemeMode.dark);
  }

  Future<void> loadTheme(ThemeMode defaultTheme) async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getBool(isDarkTheme);
    final newTheme = savedTheme == null
        ? defaultTheme
        : (savedTheme ? ThemeMode.dark : ThemeMode.light);

    emit(newTheme);
  }
}
