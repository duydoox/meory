import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';

class UpdateEntryUseCase {
  final EntryRepo _repo;

  const UpdateEntryUseCase(this._repo);

  Future<Result<bool>> execute({
    required EntryModel entry,
    bool isUpdateLastPlayedTime = false,
  }) async =>
      _repo.updateEntry(
        entry: entry,
        isUpdateLastPlayedTime: isUpdateLastPlayedTime,
      );
}
