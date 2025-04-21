part of '../core.dart';

class AppTheme {
  factory AppTheme.of(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return const AppTheme(AppThemeMode.light);
      case ThemeMode.dark:
        return const AppTheme(AppThemeMode.dark);
      default:
        return const AppTheme(AppThemeMode.light);
    }
  }

  // Light theme
  static ThemeData light() {
    final baseTheme = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.light().background,
      ),
      brightness: Brightness.light,
      useMaterial3: true,
      colorSchemeSeed: AppColors.light().primary,
      scaffoldBackgroundColor: AppColors.light().background,
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.light().white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.beVietnamProTextTheme(baseTheme.textTheme),
    );
  }

  // Dark theme
  static ThemeData dark() {
    final baseTheme = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.light().background,
      ),
      brightness: Brightness.dark,
      useMaterial3: true,
      colorSchemeSeed: AppColors.light().primary,
      scaffoldBackgroundColor: AppColors.light().background,
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.light().white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.beVietnamProTextTheme(baseTheme.textTheme),
    );
  }

  final AppThemeMode themeMode;

  const AppTheme(this.themeMode);

  AppColors get colors {
    switch (themeMode) {
      case AppThemeMode.light:
        return AppColors.light();
      case AppThemeMode.dark:
        return AppColors.light();
    }
  }
}

enum AppThemeMode { light, dark }
