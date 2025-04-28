import 'package:core/core.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';

class CountEntriesUseCase {
  final EntryRepo _repo;

  const CountEntriesUseCase(this._repo);

  Future<Result<int>> execute() async => _repo.countEntries();
}
