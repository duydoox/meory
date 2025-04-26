import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/usecases/entry/create_entry_usecase.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/toast_widget.dart';

part 'create_entry_state.dart';

class CreateEntryCubit extends CoreCubit<CreateEntryState> {
  final CreateEntryUseCase _createEntryUseCase = getIt<CreateEntryUseCase>();

  CreateEntryCubit({this.callback}) : super(const CreateEntryState());

  final VoidCallback? callback;

  final headwordController = TextEditingController();
  final definitionController = TextEditingController();
  final partsOfSpeechController = TextEditingController();
  final pronunciationController = TextEditingController();
  final categoryController = TextEditingController();

  Future<void> createEntry() async {
    if (headwordController.text.isEmpty) {
      Toast.showError("Headword cannot be empty");
      return;
    }
    if (definitionController.text.isEmpty) {
      Toast.showError("Definition cannot be empty");
      return;
    }
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _createEntryUseCase.execute(
      entry: EntryModel(
        headword: headwordController.text,
        definition: definitionController.text,
        partsOfSpeech: PartsOfSpeechE.values
            .elementAtOrNull(int.tryParse(partsOfSpeechController.text) ?? 100),
        pronunciation: pronunciationController.text,
        category: categoryController.text,
      ),
    );
    result.ifSuccess(
      (data) {
        Toast.showSuccess(
          "Entry created successfully",
        );
        callback?.call();
        emit(state.copyWith(isLoading: false));
        AppNavigator.pop();
      },
    );
    result.ifError(
      (error, dataError) {
        emit(state.copyWith(isLoading: false, errorMessage: error));
      },
    );
  }
}
