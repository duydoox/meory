import 'dart:async';

import 'package:bloc/src/change.dart';
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
  Timer? timerNext;
  Timer? timerCountdown;
  int countMiss = 0;
  bool stopped = true;

  EntryModel answerSelected = EntryModel();
  List<EntryModel> dataEntries = [];

  Future<void> getEntries() async {
    emit(state.copyWith(isLoading: stopped, errorMessage: ''));
    final result = await _getEntriesUseCase.execute(limit: 500);
    result.ifSuccess(
      (data) {
        dataEntries = data ?? [];
        final entries = _playService.getTopImportantEntries(data ?? [], take: countPerBatch);
        emit(state.copyWith(
          isLoading: false,
          entries: [...state.entries, ...entries],
          countAdded: entries.length,
        ));
        timerCountAdded?.cancel();
        timerCountAdded = Timer(
          const Duration(milliseconds: 1000),
          () {
            emit(state.copyWith(countAdded: 0));
          },
        );
        if (stopped) {
          nextIndex();
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
      entry: _playService.updateEntryResult(currentEntry, isCorrect),
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
    await submit(entry);
  }

  Future<void> submit(EntryModel entry, [bool isTimeout = false]) async {
    timerCountdown?.cancel();
    timerCountdown = null;
    answerSelected = entry;
    emit(state.copyWith(isShowAnswer: true, countdown: -1));
    updateResult(entry);
    countMiss = isTimeout ? countMiss + 1 : 0;
    timerNext = Timer(
      const Duration(milliseconds: 1000),
      () {
        if (isTimeout && countMiss > 5) {
          emit(state.copyWith(isPause: true));
          return;
        }
        nextIndex();
      },
    );
  }

  onResume() {
    countMiss = 0;
    emit(state.copyWith(isPause: false));
    nextIndex();
  }

  Future<void> nextIndex() async {
    final index = state.currentIndex + 1;
    if (index >= state.entries.length) {
      stopped = true;
      return;
    }
    stopped = false;
    if (index > state.entries.length - 2 && state.entries.length > 3) {
      getEntries();
    }
    final randomAnswers = await _playService.getRandomEntry(
      dataEntries,
      defaultEntry: state.entries.elementAtOrNull(index),
    );
    final currentScore = state.entries.elementAtOrNull(index)?.score ?? 0;
    final countdown = currentScore >= MasteryE.expert.mark
        ? 3
        : currentScore >= MasteryE.advanced.mark
            ? 5
            : -1;
    emit(state.copyWith(
      currentIndex: index,
      isShowAnswer: false,
      randomAnswers: randomAnswers,
      countdown: countdown,
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
  void onChange(Change<PlayState> change) {
    if (change.nextState.countdown != change.currentState.countdown) {
      if (change.nextState.countdown > 0) {
        timerCountdown?.cancel();
        timerCountdown = Timer(
          const Duration(milliseconds: 1000),
          () {
            emit(state.copyWith(
                countdown: change.nextState.countdown - 1,
                isShowAnswer: change.nextState.countdown == 1));
          },
        );
      } else if (change.nextState.countdown == 0) {
        timerCountdown?.cancel();
        timerCountdown = null;
        submit(EntryModel(), true);
      } else {
        timerCountdown?.cancel();
        timerCountdown = null;
      }
    }
    super.onChange(change);
  }

  @override
  Future<void> close() {
    timerCountAdded?.cancel();
    timerNext?.cancel();
    timerCountdown?.cancel();
    return super.close();
  }
}
