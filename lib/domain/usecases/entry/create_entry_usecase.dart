import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';

class CreateEntryUseCase {
  final EntryRepo _repo;

  const CreateEntryUseCase(this._repo);

  Future<Result<String>> execute({
    required EntryModel entry,
  }) async =>
      _repo.createEntry(entry: entry);
}
