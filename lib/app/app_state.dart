part of 'app_cubit.dart';

class AppState extends AppCoreState {
  final Locale? locale;
  final User? firebaseUser;

  const AppState({
    required super.themeMode,
    required super.theme,
    this.locale,
    this.firebaseUser,
  });

  @override
  List<Object?> get props => [
        themeMode,
        theme,
        locale,
        firebaseUser,
      ];

  AppState copyWith({
    AppThemeMode? themeMode,
    AppTheme? theme,
    Locale? locale,
    User? firebaseUser,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      firebaseUser: firebaseUser ?? this.firebaseUser,
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
