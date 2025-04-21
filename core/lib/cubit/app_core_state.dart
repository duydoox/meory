part of '../core.dart';

abstract class AppCoreState extends Equatable {
  final AppTheme theme;
  final AppThemeMode themeMode;

  const AppCoreState({
    required this.theme,
    required this.themeMode,
  });
}
