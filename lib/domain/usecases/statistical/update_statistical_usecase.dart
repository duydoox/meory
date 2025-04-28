import 'package:core/core.dart';
import 'package:meory/domain/repositories/statistical/statistical_repo.dart';

class UpdateStatisticalUseCase {
  final StatisticalRepo _repo;

  const UpdateStatisticalUseCase(this._repo);

  Future<Result<bool>> execute({
    required bool result,
  }) async =>
      _repo.updateStatistical(result: result);
}
