import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';

mixin EntryRepo {
  Future<Result<List<EntryModel>>> getEntries({int limit = 30});

  Future<Result<EntryModel>> getEntry({required String entryId});

  Future<Result<String>> createEntry({required EntryModel entry});

  Future<Result<bool>> updateEntry({
    required EntryModel entry,
    bool isUpdateLastPlayedTime = false,
  });

  Future<Result<bool>> deleteEntry({required String entryId});

  Future<Result<int>> countEntries();

  Future<Result<int>> countMastered();

  Future<Result<List<EntryModel>>> getHomeEntries();
}
