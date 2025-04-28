import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/usecases/entry/create_entry_usecase.dart';
import 'package:meory/domain/usecases/entry/update_entry_usecase.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/input_dropdown/input_dropdown.dart';
import 'package:meory/presentations/widgets/toast_widget.dart';

part 'create_entry_state.dart';

class CreateEntryCubit extends CoreCubit<CreateEntryState> {
  final _createEntryUseCase = getIt<CreateEntryUseCase>();
  final _updateEntryUseCase = getIt<UpdateEntryUseCase>();

  CreateEntryCubit({this.callback, this.entry}) : super(const CreateEntryState());

  final EntryModel? entry;
  final VoidCallback? callback;

  bool get isEdit => entry != null;

  final headwordController = TextEditingController();
  final definitionController = TextEditingController();
  final partsOfSpeechController = InputController<PartsOfSpeechE>(null);
  final pronunciationController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final noteController = TextEditingController();
  final topicController = TextEditingController();

  init() {
    if (isEdit) {
      headwordController.text = entry?.headword ?? '';
      definitionController.text = entry?.definition ?? '';
      partsOfSpeechController.value = entry?.partsOfSpeech;
      pronunciationController.text = entry?.pronunciation ?? '';
      categoryController.text = entry?.category ?? '';
    }
  }

  onTapSubmit() {
    if (isEdit) {
      updateEntry();
    } else {
      createEntry();
    }
  }

  Future<void> updateEntry() async {
    if (entry == null) return;
    if (headwordController.text.isEmpty) {
      Toast.showError("Headword cannot be empty");
      return;
    }
    if (definitionController.text.isEmpty) {
      Toast.showError("Definition cannot be empty");
      return;
    }
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _updateEntryUseCase.execute(
      entry: entry!.copyWith(
        headword: headwordController.text,
        definition: definitionController.text,
        partsOfSpeech: partsOfSpeechController.value,
        pronunciation: pronunciationController.text,
        category: categoryController.text,
        description: descriptionController.text,
        note: noteController.text,
        topic: topicController.text,
      ),
    );
    result.ifSuccess(
      (data) {
        Toast.showSuccess(
          "Entry updated successfully",
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
        partsOfSpeech: partsOfSpeechController.value,
        pronunciation: pronunciationController.text,
        category: categoryController.text,
        description: descriptionController.text,
        note: noteController.text,
        topic: topicController.text,
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
