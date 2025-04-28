import 'package:core/core.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';

class CountMasteredUseCase {
  final EntryRepo _repo;

  const CountMasteredUseCase(this._repo);

  Future<Result<int>> execute() async => _repo.countMastered();
}
