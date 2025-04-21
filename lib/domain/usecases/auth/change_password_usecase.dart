import 'package:core/core.dart';
import 'package:meory/domain/repositories/auth/auth_repo.dart';

class ChangePasswordUseCase {
  final AuthRepo _repo;

  const ChangePasswordUseCase(this._repo);

  Future<Result<bool>> execute({
    required String tokenVerifyOTP,
    required String password,
  }) async =>
      _repo.changePassword(tokenVerifyOTP: tokenVerifyOTP, password: password);
}
