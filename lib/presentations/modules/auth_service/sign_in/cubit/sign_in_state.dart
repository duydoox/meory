import 'package:core/core.dart';

class SignInState extends CoreState {
  final String username;
  final String password;
  const SignInState({
    super.isLoading,
    super.errorMessage,
    this.username = '',
    this.password = '',
  });

  @override
  SignInState copyWith({
    bool? isLoading,
    String? username,
    String? password,
    String? errorMessage,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, username, password, errorMessage];
}
