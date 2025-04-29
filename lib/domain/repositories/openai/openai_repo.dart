import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';

mixin OpenaiRepo {
  Future<Result<List<EntryModel>>> getPromptWord({required String word});
}
