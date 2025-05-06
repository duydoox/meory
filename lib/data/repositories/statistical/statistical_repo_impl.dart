import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:meory/data/data_source/remote/base_repository.dart';
import 'package:meory/data/data_source/remote/firebase_conllection.dart';
import 'package:meory/data/models/statistical_week/statistical_day_model.dart';
import 'package:meory/data/models/statistical_week/statistical_model.dart';
import 'package:meory/domain/repositories/statistical/statistical_repo.dart';

class StatisticalRepoImpl extends BaseRepository with StatisticalRepo {
  @override
  Future<Result<bool>> updateStatistical({required bool result}) async {
    try {
      final statistical = firestore
          .collection(
            FireBaseConllection.statistical,
          )
          .doc(fireAuth.currentUser?.uid)
          .set(
        {
          'streak': result ? FieldValue.increment(1) : 0,
          'lastPlayedTime': FieldValue.serverTimestamp(),
          'numberOfPlayed': FieldValue.increment(1),
          if (result) 'numberOfSuccess': FieldValue.increment(1),
        },
        SetOptions(merge: true),
      );
      final day = DateTime.now();
      final statisticalDayModel = StatisticalDayModel(
        userId: fireAuth.currentUser?.uid,
        date: Timestamp.fromDate(DateTime(day.year, day.month, day.day)),
      );
      final statisticalDay = firestore
          .collection(
            FireBaseConllection.statisticalDay,
          )
          .doc(statisticalDayModel.createId)
          .set(
        {
          ...statisticalDayModel.toJsonUpdate(),
          'lastPlayedTime': FieldValue.serverTimestamp(),
          'numberOfPlayed': FieldValue.increment(1),
          if (result) 'numberOfSuccess': FieldValue.increment(1),
        },
        SetOptions(merge: true),
      );
      await Future.wait([statistical, statisticalDay]);
      return Result.success(true);
    } catch (e) {
      return Result.error(e.toString(), '');
    }
  }

  @override
  Future<Result<StatisticalModel>> getStatistical() async {
    try {
      final snapshot = await firestore
          .collection(
            FireBaseConllection.statistical,
          )
          .doc(fireAuth.currentUser?.uid)
          .get();
      return Result.success(StatisticalModel.fromJson(snapshot.data() ?? {}));
    } catch (e) {
      return Result.error(e.toString(), '');
    }
  }

  @override
  Future<Result<List<StatisticalDayModel>>> getListStatisticalByDay({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final snapshot = await firestore
          .collection(
            FireBaseConllection.statisticalDay,
          )
          .where(
            'userId',
            isEqualTo: fireAuth.currentUser?.uid,
          )
          .where(
            'date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(
              DateTime(startDate?.year ?? 0, startDate?.month ?? 0, startDate?.day ?? 0),
            ),
          )
          .where(
            'date',
            isLessThanOrEqualTo: Timestamp.fromDate(
              DateTime(endDate?.year ?? 4000, endDate?.month ?? 0, endDate?.day ?? 0),
            ),
          )
          .get();
      return Result.success(
          snapshot.docs.map((doc) => StatisticalDayModel.fromJson(doc.data())).toList());
    } catch (e) {
      return Result.error(e.toString(), '');
    }
  }

  @override
  Future<Result<StatisticalDayModel>> getStatisticalByDay({DateTime? day}) async {
    try {
      final statisticalDayModel = StatisticalDayModel(
        userId: fireAuth.currentUser?.uid,
        date: Timestamp.fromDate(DateTime(day?.year ?? 0, day?.month ?? 0, day?.day ?? 0)),
      );
      final snapshot = await firestore
          .collection(
            FireBaseConllection.statisticalDay,
          )
          .doc(statisticalDayModel.createId)
          .get();
      return Result.success(StatisticalDayModel.fromJson(snapshot.data() ?? {}));
    } catch (e) {
      return Result.error(e.toString(), '');
    }
  }
}
