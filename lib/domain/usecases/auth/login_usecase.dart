import 'package:core/core.dart';
import 'package:meory/domain/repositories/auth/auth_repo.dart';

class LoginUseCase {
  final AuthRepo _repo;

  const LoginUseCase(this._repo);

  Future<Result<TokenData>> execute({
    required String username,
    required String password,
  }) async =>
      _repo.login(
        username: username,
        password: password,
      );
}
