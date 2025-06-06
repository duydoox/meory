import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/usecases/entry/create_entry_usecase.dart';
import 'package:meory/domain/usecases/entry/get_entries_by_headword_usecase.dart';
import 'package:meory/domain/usecases/entry/update_entry_usecase.dart';
import 'package:meory/domain/usecases/openai/get_prompt_word_usecase.dart';
import 'package:meory/presentations/modules/home/cubit/home_cubit.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/input_dropdown/input_dropdown.dart';
import 'package:meory/presentations/widgets/toast_widget.dart';

part 'create_entry_state.dart';

class CreateEntryCubit extends CoreCubit<CreateEntryState> {
  final _createEntryUseCase = getIt<CreateEntryUseCase>();
  final _updateEntryUseCase = getIt<UpdateEntryUseCase>();
  final _getPromptWordUseCase = getIt<GetPromptWordUseCase>();
  final _getEntriesByHeadwordUseCase = getIt<GetEntriesByHeadwordUseCase>();

  CreateEntryCubit({this.callback, this.entry}) : super(const CreateEntryState());

  final EntryModel? entry;
  final VoidCallback? callback;

  bool get isEdit => entry != null;

  final headwordController = TextEditingController();
  final definitionController = TextEditingController();
  final partsOfSpeechController = InputController<PartsOfSpeechE>(null);
  final pronunciationController = TextEditingController();
  final categoryController = TextEditingController();
  final exampleController = TextEditingController();
  final noteController = TextEditingController();
  final topicController = TextEditingController();

  init() {
    if (isEdit) {
      headwordController.text = entry?.headword ?? '';
      definitionController.text = entry?.definition ?? '';
      partsOfSpeechController.value = entry?.partsOfSpeech;
      pronunciationController.text = entry?.pronunciation ?? '';
      categoryController.text = entry?.category ?? '';
      exampleController.text = entry?.example ?? '';
      noteController.text = entry?.note ?? '';
      topicController.text = entry?.topic ?? '';
    }
  }

  onTapSubmit() {
    if (isEdit) {
      updateEntry();
    } else {
      checkForCreate();
    }
  }

  Future<void> getPromptWord() async {
    if (state.isLoading || headwordController.text.trim().isEmpty) return;
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _getPromptWordUseCase.execute(
      word: headwordController.text,
    );
    result.ifSuccess(
      (data) {
        emit(state.copyWith(isLoading: false, prompts: data ?? []));
      },
    );
    result.ifError(
      (error, dataError) {
        emit(state.copyWith(isLoading: false, errorMessage: error));
      },
    );
  }

  onTapPrompt(EntryModel prompt) {
    headwordController.text = prompt.headword ?? '';
    definitionController.text = prompt.definition ?? '';
    partsOfSpeechController.value = prompt.partsOfSpeech;
    pronunciationController.text = prompt.pronunciation ?? '';
    categoryController.text = prompt.category ?? '';
    topicController.text = prompt.topic ?? '';
    exampleController.text = prompt.example ?? '';
    emit(state.copyWith(prompts: []));
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
        example: exampleController.text,
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
        AppNavigator.pop();
      },
    );
    result.ifError(
      (error, dataError) {
        emit(state.copyWith(isLoading: false, errorMessage: error));
      },
    );
  }

  Future<void> checkForCreate() async {
    if (headwordController.text.trim().isEmpty) {
      Toast.showError("Headword cannot be empty");
      return;
    }
    if (definitionController.text.trim().isEmpty) {
      Toast.showError("Definition cannot be empty");
      return;
    }
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final entriesResult = await _getEntriesByHeadwordUseCase.execute(
      headword: headwordController.text.trim(),
    );
    if (entriesResult.isSuccess) {
      final entries = entriesResult.data ?? [];
      if (entries.isNotEmpty) {
        emit(state.copyWith(isLoading: false, entriesExist: entries));
        return;
      }
    }
    await createEntry();
  }

  Future<void> createEntry() async {
    if (headwordController.text.trim().isEmpty) {
      Toast.showError("Headword cannot be empty");
      return;
    }
    if (definitionController.text.trim().isEmpty) {
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
        example: exampleController.text,
        note: noteController.text,
        topic: topicController.text,
      ),
    );
    result.ifSuccess(
      (data) {
        HomeCubit.neededRefreshData = true;
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
