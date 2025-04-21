import 'package:core/core.dart';
import 'package:meory/data/models/auth/verify_otp_model.dart';
import 'package:meory/domain/repositories/auth/auth_repo.dart';

class VerifyOtpUseCase {
  final AuthRepo _repo;

  const VerifyOtpUseCase(this._repo);

  Future<Result<VerifyOtpModel>> execute({
    required String tokenVerify,
    required String otp,
  }) async =>
      _repo.verifyOtp(tokenVerify: tokenVerify, otp: otp);
}
