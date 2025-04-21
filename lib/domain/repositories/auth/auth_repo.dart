import 'package:core/core.dart';
import 'package:meory/data/models/auth/send_email_model.dart';
import 'package:meory/data/models/auth/verify_otp_model.dart';

mixin AuthRepo {
  Future<Result<TokenData>> login({required String username, required String password});

  Future<Result<SendEmailModel>> sendEmail({required String email});

  Future<Result<VerifyOtpModel>> verifyOtp({required String tokenVerify, required String otp});

  Future<Result<bool>> changePassword({required String tokenVerifyOTP, required String password});
}
