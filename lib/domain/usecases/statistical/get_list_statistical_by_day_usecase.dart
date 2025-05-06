import 'package:core/core.dart';
import 'package:meory/data/models/statistical_week/statistical_day_model.dart';
import 'package:meory/domain/repositories/statistical/statistical_repo.dart';

class GetListStatisticalByDayUseCase {
  final StatisticalRepo _repo;

  const GetListStatisticalByDayUseCase(this._repo);

  Future<Result<List<StatisticalDayModel>>> execute({
    DateTime? startDate,
    DateTime? endDate,
  }) async =>
      _repo.getListStatisticalByDay(
        startDate: startDate,
        endDate: endDate,
      );
}
