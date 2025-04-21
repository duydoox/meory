part of 'splash_cubit.dart';

class SplashState extends CoreState {
  final String title;

  const SplashState({
    super.errorMessage,
    super.isLoading,
    this.title = '',
  });

  @override
  List<Object> get props => [title, isLoading, errorMessage];

  @override
  SplashState copyWith({
    String? title,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SplashState(
      title: title ?? this.title,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
