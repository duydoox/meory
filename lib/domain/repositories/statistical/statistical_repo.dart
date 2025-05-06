import 'package:core/core.dart';
import 'package:meory/data/models/statistical_week/statistical_day_model.dart';
import 'package:meory/data/models/statistical_week/statistical_model.dart';

mixin StatisticalRepo {
  Future<Result<bool>> updateStatistical({required bool result});

  Future<Result<StatisticalModel>> getStatistical();

  Future<Result<List<StatisticalDayModel>>> getListStatisticalByDay({
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Result<StatisticalDayModel>> getStatisticalByDay({
    DateTime? day,
  });
}
