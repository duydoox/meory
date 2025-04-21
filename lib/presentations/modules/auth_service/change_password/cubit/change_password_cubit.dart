import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/domain/usecases/auth/change_password_usecase.dart';
import 'package:meory/domain/usecases/auth/login_usecase.dart';
import 'package:meory/presentations/routes.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends CoreCubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  final LoginUseCase _loginUseCase;
  ChangePasswordCubit({required this.email, required this.tokenVerifyOTP})
      : _changePasswordUseCase = getIt<ChangePasswordUseCase>(),
        _loginUseCase = getIt<LoginUseCase>(),
        super(const ChangePasswordState());

  final String email;
  final String tokenVerifyOTP;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  checkPassword() {
    emit(state.copyWith(
      isSatisfyLength: passwordController.text.length >= 8 && passwordController.text.length <= 16,
      isUpAndLowerCase: passwordController.text.contains(RegExp(r'[a-z]')) &&
          passwordController.text.contains(RegExp(r'[A-Z]')),
      isSatisfySpecialChar: passwordController.text.contains(RegExp(r'[^\w\s]')),
      isMatchPassword: passwordController.text == confirmPasswordController.text,
    ));
  }

  checkConfirmPassword() {
    emit(state.copyWith(
      isMatchPassword: passwordController.text == confirmPasswordController.text,
    ));
  }

  Future<void> onTapConfirm() async {
    if (!state.isMatchPassword ||
        !state.isSatisfyLength ||
        !state.isUpAndLowerCase ||
        !state.isSatisfySpecialChar) {
      return;
    }
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _changePasswordUseCase.execute(
        tokenVerifyOTP: tokenVerifyOTP, password: passwordController.text);
    result.ifSuccess((data) async {
      emit(state.copyWith(isLoading: false));
      await login();
      AppNavigator.pushNamed(Routes.signUpCompleted.path, {
        'email': email,
        'password': passwordController.text,
      });
    });
    result.ifError((error, errorData) {
      emit(state.copyWith(isLoading: false, errorMessage: error ?? 'Error'));
    });
  }

  Future<void> login() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _loginUseCase.execute(
      username: email,
      password: passwordController.text,
    );
    if (result.isSuccess) {
      await AppSecureStorage.setToken(result.data);
      emit(state.copyWith(isLoading: false));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.error ?? 'Có lỗi xảy ra',
      ));
    }
  }
}
