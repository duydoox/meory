import 'package:core/core.dart';
import 'package:meory/data/models/auth/send_email_model.dart';
import 'package:meory/domain/repositories/auth/auth_repo.dart';

class SendEmailUseCase {
  final AuthRepo _repo;

  const SendEmailUseCase(this._repo);

  Future<Result<SendEmailModel>> execute({
    required String email,
  }) async =>
      _repo.sendEmail(email: email);
}
