import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';

class GetEntriesByHeadwordUseCase {
  final EntryRepo _repo;

  const GetEntriesByHeadwordUseCase(this._repo);

  Future<Result<List<EntryModel>>> execute({
    required String headword,
  }) async =>
      _repo.getEntriesByHeadword(
        headword: headword,
      );
}
