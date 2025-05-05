import 'dart:async';

import 'package:core/core.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/usecases/entry/get_entries_usecase.dart';
import 'package:meory/domain/usecases/entry/update_entry_usecase.dart';
import 'package:meory/domain/usecases/statistical/update_statistical_usecase.dart';
import 'package:meory/presentations/modules/home/cubit/home_cubit.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/service/audio_service.dart';
import 'package:meory/presentations/service/play_service.dart';
import 'package:meory/presentations/service/tts_service.dart';
import 'package:meory/presentations/widgets/toast_widget.dart';

part 'play_state.dart';

class PlayCubit extends CoreCubit<PlayState> {
  final GetEntriesUseCase _getEntriesUseCase = getIt<GetEntriesUseCase>();
  final _updateEntryUseCase = getIt<UpdateEntryUseCase>();
  final _updateStatisticalUseCase = getIt<UpdateStatisticalUseCase>();
  final PlayService _playService = getIt<PlayService>();
  PlayCubit() : super(const PlayState());

  final countPerBatch = 30;
  Timer? timerCountAdded;

  EntryModel answerSelected = EntryModel();

  Future<void> getEntries([bool reset = true]) async {
    emit(state.copyWith(isLoading: reset, errorMessage: ''));
    final result = await _getEntriesUseCase.execute();
    result.ifSuccess(
      (data) {
        final entries = _playService.getTopImportantEntries(data ?? [], take: countPerBatch);
        emit(state.copyWith(
          isLoading: false,
          entries: reset ? entries : [...state.entries, ...entries],
          countAdded: entries.length,
        ));
        timerCountAdded?.cancel();
        timerCountAdded = Timer(
          const Duration(milliseconds: 1000),
          () {
            emit(state.copyWith(countAdded: 0));
          },
        );
        if (reset) {
          onIndexChange(0);
        }
      },
    );
    result.ifError(
      (error, dataError) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: error ?? 'Error retrieving entries',
          ),
        );
      },
    );
  }

  Future<void> updateResult(EntryModel entry) async {
    final currentEntry = state.entries.elementAtOrNull(state.currentIndex);
    if (currentEntry == null) return;
    final isCorrect = entry.id == currentEntry.id;
    if (isCorrect) {
      AudioService().play(AudioType.ting);
    } else {
      AudioService().play(AudioType.wrong);
    }
    final result = await _updateEntryUseCase.execute(
      entry: _playService.updateEntryResult(entry, isCorrect),
      isUpdateLastPlayedTime: true,
    );
    result.ifSuccess((data) async {
      final resultStatistic = await _updateStatisticalUseCase.execute(result: isCorrect);

      resultStatistic.ifSuccess((data) {
        HomeCubit.neededRefreshData = true;
      });

      resultStatistic.ifError((error, errorData) {
        Toast.showError(error ?? 'Error updating entry');
      });
    });
    result.ifError((error, dataError) {
      Toast.showError(error ?? 'Error updating entry');
    });
  }

  void onTapAnswer(EntryModel entry) async {
    answerSelected = entry;
    emit(state.copyWith(isShowAnswer: true));
    updateResult(entry);
    await Future.delayed(const Duration(milliseconds: 1000));
    onIndexChange(state.currentIndex + 1);
  }

  Future<void> onIndexChange(int index) async {
    if (index >= state.entries.length) {
      Toast.showInfo("End");
      return;
    }
    if (index > state.entries.length - 3 && state.entries.length > 3) {
      getEntries(false);
    }
    final randomAnswers = await _playService.getRandomEntry(
      state.entries,
      defaultEntry: state.entries.elementAtOrNull(index),
    );
    emit(state.copyWith(
      currentIndex: index,
      isShowAnswer: false,
      randomAnswers: randomAnswers,
    ));
    speak();
  }

  void speak() {
    TtsService().speak(
      state.entries.elementAtOrNull(state.currentIndex)?.headword ?? '',
    );
  }

  void onTapAdd() {
    AppNavigator.push(Routes.createEntry, {
      'callback': getEntries,
    });
  }

  @override
  Future<void> close() {
    timerCountAdded?.cancel();
    return super.close();
  }
}
