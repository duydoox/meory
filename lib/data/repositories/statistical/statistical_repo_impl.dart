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
      final data = snapshot.docs.map((doc) => StatisticalDayModel.fromJson(doc.data())).toList();
      data.sort((a, b) => a.date?.compareTo(b.date ?? Timestamp.now()) ?? 0);
      if (data.last.toDate != null && endDate != null) {
        data.addAll(
          List.generate(
            endDate.difference(data.last.toDate!).inDays,
            (index) => StatisticalDayModel(
              date: Timestamp.fromDate(
                data.last.toDate!.add(Duration(days: index + 1)),
              ),
              numberOfPlayed: 0,
              numberOfSuccess: 0,
            ),
          ),
        );
      }
      for (int i = 0; i < data.length - 1; i++) {
        if (data[i].toDate == null || data[i + 1].toDate == null) {
          continue;
        }
        final date = DateTime(
          data[i].toDate!.year,
          data[i].toDate!.month,
          data[i].toDate!.day + 1,
        );
        final dateNext = DateTime(
          data[i + 1].toDate!.year,
          data[i + 1].toDate!.month,
          data[i + 1].toDate!.day,
        );
        if (date.isAtSameMomentAs(dateNext)) {
          continue;
        }
        data.insert(
            i + 1,
            StatisticalDayModel(
              date: Timestamp.fromDate(date),
              numberOfPlayed: 0,
              numberOfSuccess: 0,
            ));
      }
      return Result.success(data);
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
