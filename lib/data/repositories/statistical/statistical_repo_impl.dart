import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:meory/data/data_source/remote/base_repository.dart';
import 'package:meory/data/data_source/remote/firebase_conllection.dart';
import 'package:meory/data/models/statistical_week/statistical_model.dart';
import 'package:meory/domain/repositories/statistical/statistical_repo.dart';

class StatisticalRepoImpl extends BaseRepository with StatisticalRepo {
  @override
  Future<Result<bool>> updateStatistical({required bool result}) async {
    try {
      final snapshot = await firestore
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
}
