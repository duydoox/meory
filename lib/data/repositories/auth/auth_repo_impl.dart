import 'package:core/core.dart';
import 'package:meory/data/data_source/remote/api_endpoints.dart';
import 'package:meory/data/models/auth/send_email_model.dart';
import 'package:meory/data/models/auth/verify_otp_model.dart';
import 'package:meory/domain/repositories/auth/auth_repo.dart';

import '../../data_source/remote/base_repository.dart';

class AuthRepoImpl extends BaseRepository implements AuthRepo {
  @override
  Future<Result<TokenData>> login({required String username, required String password}) async {
    try {
      final response = await post(ApiEndpoints.login, {
        'username': username,
        'password': password,
      });
      return Result.success(TokenData.fromJson(response.data ?? {}));
    } catch (e) {
      return Result.error(catchError(e), e);
    }
  }

  @override
  Future<Result<SendEmailModel>> sendEmail({required String email}) async {
    try {
      final response = await post(ApiEndpoints.sendEmail, {}, {
        'email': email,
      });
      return Result.success(SendEmailModel.fromJson(response.data['data'] ?? {}));
    } catch (e) {
      return Result.error(catchError(e), e);
    }
  }

  @override
  Future<Result<VerifyOtpModel>> verifyOtp(
      {required String tokenVerify, required String otp}) async {
    try {
      final response = await post(ApiEndpoints.vefifyOtp, {}, {
        'tokenVerify': tokenVerify,
        'digitalOtp': otp,
      });
      return Result.success(VerifyOtpModel.fromJson(response.data['data'] ?? {}));
    } catch (e) {
      return Result.error(catchError(e), e);
    }
  }

  @override
  Future<Result<bool>> changePassword(
      {required String tokenVerifyOTP, required String password}) async {
    try {
      final response = await post(ApiEndpoints.firstPassword, {}, {
        'tokenVerify': tokenVerifyOTP,
        'password': password,
        'rePassword': password,
      });
      return Result.success(response.data['data']['status'] ?? false);
    } catch (e) {
      return Result.error(catchError(e), e);
    }
  }
}
