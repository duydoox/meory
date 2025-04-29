import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/repositories/openai/openai_repo.dart';

class GetPromptWordUseCase {
  final OpenaiRepo _repo;

  const GetPromptWordUseCase(this._repo);

  Future<Result<List<EntryModel>>> execute({
    required word,
  }) async =>
      _repo.getPromptWord(word: word);
}
