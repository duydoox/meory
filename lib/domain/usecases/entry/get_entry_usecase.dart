import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';

class GetEntryUseCase {
  final EntryRepo _repo;

  const GetEntryUseCase(this._repo);

  Future<Result<EntryModel>> execute({
    required String entryId,
  }) async =>
      _repo.getEntry(entryId: entryId);
}
