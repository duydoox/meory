import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';

class GetEntriesUseCase {
  final EntryRepo _repo;

  const GetEntriesUseCase(this._repo);

  Future<Result<List<EntryModel>>> execute() async => _repo.getEntries();
}
