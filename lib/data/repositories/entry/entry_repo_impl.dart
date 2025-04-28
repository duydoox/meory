import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:meory/data/data_source/remote/base_repository.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';

import '../../data_source/remote/firebase_conllection.dart';

class EntryRepoImpl extends BaseRepository with EntryRepo {
  @override
  Future<Result<List<EntryModel>>> getEntries({int limit = 30}) async {
    try {
      final snapshot = await firestore
          .collection(FireBaseConllection.entries)
          .where('userId', isEqualTo: fireAuth.currentUser?.uid)
          .orderBy('score')
          .limit(limit)
          .get();
      return Result.success(
          snapshot.docs.map((doc) => EntryModel.fromJson({...doc.data(), 'id': doc.id})).toList());
    } catch (e) {
      return Result.error(catchError(e), '');
    }
  }

  @override
  Future<Result<EntryModel>> getEntry({required String entryId}) async {
    try {
      final snapshot = await firestore.collection(FireBaseConllection.entries).doc(entryId).get();
      if (snapshot.exists) {
        return Result.success(EntryModel.fromJson({...snapshot.data()!, 'id': snapshot.id}));
      }
      return Result.error('Entry not found', '');
    } catch (e) {
      return Result.error(e.toString(), '');
    }
  }

  @override
  Future<Result<String>> createEntry({required EntryModel entry}) async {
    try {
      final snapshot = await firestore.collection(FireBaseConllection.entries).add({
        ...entry.toUpdate(),
        'userId': fireAuth.currentUser?.uid,
        'lastPlayedTime': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      return Result.success(snapshot.id);
    } catch (e) {
      return Result.error(catchError(e), '');
    }
  }

  @override
  Future<Result<bool>> updateEntry({
    required EntryModel entry,
    bool isUpdateLastPlayedTime = false,
  }) async {
    try {
      if (entry.id == null) {
        return Result.error('Entry ID is null', '');
      }
      final snapshot = await firestore
          .collection(
            FireBaseConllection.entries,
          )
          .doc(entry.id)
          .update(
        {
          ...entry.toUpdate(),
          if (isUpdateLastPlayedTime) 'lastPlayedTime': FieldValue.serverTimestamp(),
        },
      );
      return Result.success(true);
    } catch (e) {
      return Result.error(e.toString(), '');
    }
  }

  @override
  Future<Result<bool>> deleteEntry({required String entryId}) async {
    try {
      await firestore.collection(FireBaseConllection.entries).doc(entryId).delete();
      return Result.success(true);
    } catch (e) {
      return Result.error(e.toString(), '');
    }
  }

  @override
  Future<Result<int>> countEntries() async {
    try {
      final snapshot = await firestore
          .collection(FireBaseConllection.entries)
          .where('userId', isEqualTo: fireAuth.currentUser?.uid)
          .count()
          .get();

      return Result.success(snapshot.count);
    } catch (e) {
      return Result.error(catchError(e), '');
    }
  }

  @override
  Future<Result<int>> countMastered() async {
    try {
      final snapshot = await firestore
          .collection(FireBaseConllection.entries)
          .where('userId', isEqualTo: fireAuth.currentUser?.uid)
          .where('score', isGreaterThan: 70)
          .where('numberOfPlayed', isGreaterThanOrEqualTo: 20)
          .count()
          .get();

      return Result.success(snapshot.count);
    } catch (e) {
      return Result.error(catchError(e), '');
    }
  }

  @override
  Future<Result<List<EntryModel>>> getHomeEntries() async {
    try {
      final snapshot = await firestore
          .collection(FireBaseConllection.entries)
          .where('userId', isEqualTo: fireAuth.currentUser?.uid)
          .where('numberOfPlayed', isGreaterThan: 0)
          .orderBy('lastPlayedTime')
          .limit(5)
          .get();
      return Result.success(
          snapshot.docs.map((doc) => EntryModel.fromJson({...doc.data(), 'id': doc.id})).toList());
    } catch (e) {
      return Result.error(catchError(e), '');
    }
  }
}
