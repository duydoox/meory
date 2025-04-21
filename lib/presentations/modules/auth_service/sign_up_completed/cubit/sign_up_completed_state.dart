part of 'sign_up_completed_cubit.dart';

class SignUpCompletedState extends CoreState {
  const SignUpCompletedState({
    bool isLoading = false,
    String errorMessage = '',
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  SignUpCompletedState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignUpCompletedState(
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
