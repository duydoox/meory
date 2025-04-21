import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/domain/usecases/auth/send_email_usecase.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

import 'sign_up_with_email_state.dart';

class SignUpWithEmailCubit extends CoreCubit<SignUpWithEmailState> {
  final SendEmailUseCase _sendEmailUseCase;
  SignUpWithEmailCubit()
      : _sendEmailUseCase = getIt<SendEmailUseCase>(),
        super(const SignUpWithEmailState());

  final formInputText = FormInputText();
  final emailController = TextEditingController();

  Future<void> onTapConfirm() async {
    if (formInputText.validate() != true) {
      return;
    }
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _sendEmailUseCase.execute(email: emailController.text);
    result.ifSuccess((data) {
      emit(state.copyWith(isLoading: false));
      AppNavigator.pushNamed(Routes.otp.path, {
        'email': emailController.text,
        'tokenVerify': data?.tokenOTP,
      });
    });
    result.ifError((error, errorData) {
      emit(state.copyWith(isLoading: false, errorMessage: error ?? 'Error'));
    });
  }
}
