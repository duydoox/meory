part of 'auth_cubit.dart';

class AuthState extends CoreState {
  final String? name;

  const AuthState({
    this.name,
    bool isLoading = false,
    String errorMessage = '',
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      name: name ?? name,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        isLoading,
        errorMessage,
      ];
}
