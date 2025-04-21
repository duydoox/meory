part of 'change_password_cubit.dart';

class ChangePasswordState extends CoreState {
  final bool isSatisfyLength;
  final bool isUpAndLowerCase;
  final bool isSatisfySpecialChar;
  final bool isMatchPassword;
  const ChangePasswordState({
    bool isLoading = false,
    String errorMessage = '',
    this.isSatisfyLength = false,
    this.isUpAndLowerCase = false,
    this.isSatisfySpecialChar = false,
    this.isMatchPassword = false,
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  ChangePasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSatisfyLength,
    bool? isUpAndLowerCase,
    bool? isSatisfySpecialChar,
    bool? isMatchPassword,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSatisfyLength: isSatisfyLength ?? this.isSatisfyLength,
      isUpAndLowerCase: isUpAndLowerCase ?? this.isUpAndLowerCase,
      isSatisfySpecialChar: isSatisfySpecialChar ?? this.isSatisfySpecialChar,
      isMatchPassword: isMatchPassword ?? this.isMatchPassword,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        isSatisfyLength,
        isUpAndLowerCase,
        isSatisfySpecialChar,
        isMatchPassword,
      ];
}
