import 'package:core/core.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';

class DeleteEntryUseCase {
  final EntryRepo _repo;

  const DeleteEntryUseCase(this._repo);

  Future<Result<bool>> execute({
    required String entryId,
  }) async =>
      _repo.deleteEntry(entryId: entryId);
}
