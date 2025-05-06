import 'package:core/core.dart';
import 'package:meory/data/models/statistical_week/statistical_day_model.dart';
import 'package:meory/domain/repositories/statistical/statistical_repo.dart';

class GetStatisticalByDayUseCase {
  final StatisticalRepo _repo;

  const GetStatisticalByDayUseCase(this._repo);

  Future<Result<StatisticalDayModel>> execute({DateTime? day}) async =>
      _repo.getStatisticalByDay(day: day);
}
