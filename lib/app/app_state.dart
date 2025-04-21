part of 'app_cubit.dart';

class AppState extends AppCoreState {
  final Locale? locale;

  const AppState({
    required super.themeMode,
    required super.theme,
    this.locale,
  });

  @override
  List<Object?> get props => [
        themeMode,
        theme,
        locale,
      ];

  AppState copyWith({
    AppThemeMode? themeMode,
    AppTheme? theme,
    Locale? locale,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
    );
  }
}

final class AppInitial extends AppState {
  const AppInitial()
      : super(
          themeMode: AppThemeMode.light,
          theme: const AppTheme(AppThemeMode.light),
        );
}
