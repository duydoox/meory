import 'package:core/core.dart';

class SignUpWithEmailState extends CoreState {
  const SignUpWithEmailState({
    bool isLoading = false,
    String errorMessage = '',
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  SignUpWithEmailState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignUpWithEmailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
      ];
}
