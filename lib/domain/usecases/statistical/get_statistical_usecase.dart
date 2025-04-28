import 'package:core/core.dart';
import 'package:meory/data/models/statistical_week/statistical_model.dart';
import 'package:meory/domain/repositories/statistical/statistical_repo.dart';

class GetStatisticalUseCase {
  final StatisticalRepo _repo;

  const GetStatisticalUseCase(this._repo);

  Future<Result<StatisticalModel>> execute() async => _repo.getStatistical();
}
