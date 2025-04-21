import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/domain/usecases/auth/send_email_usecase.dart';
import 'package:meory/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

import 'otp_state.dart';

class OtpCubit extends CoreCubit<OtpState> {
  final VerifyOtpUseCase _verifyOtpUseCase;
  final SendEmailUseCase _sendEmailUseCase;
  OtpCubit({required this.email, required this.tokenVerify})
      : _sendEmailUseCase = getIt<SendEmailUseCase>(),
        _verifyOtpUseCase = getIt<VerifyOtpUseCase>(),
        super(const OtpState());

  final String email;
  final String tokenVerify;

  final formInputText = FormInputText();
  final codeController = TextEditingController();

  Future<void> resend() async {
    if (formInputText.validate() != true) {
      return;
    }
    emit(state.copyWith(isLoading: true, verifying: false, errorMessage: ''));
    final result = await _sendEmailUseCase.execute(email: email);
    result.ifSuccess((data) {
      emit(state.copyWith(isLoading: false, verifying: false));
      emit(state.copyWith(verifying: true));
    });
    result.ifError((error, errorData) {
      emit(state.copyWith(isLoading: false, errorMessage: error ?? 'Error'));
    });
  }

  Future<void> onTapConfirm() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result =
        await _verifyOtpUseCase.execute(tokenVerify: tokenVerify, otp: codeController.text);
    result.ifSuccess((data) {
      emit(state.copyWith(isLoading: false, errorMessage: ''));
      AppNavigator.push(Routes.changePassword, {
        'email': email,
        'tokenVerifyOTP': data?.tokenVerifyOTP ?? '',
      });
    });
    result.ifError((error, errorData) {
      emit(state.copyWith(isLoading: false, errorMessage: error ?? 'Error'));
    });
  }
}
