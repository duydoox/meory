part of 'play_cubit.dart';

class PlayState extends CoreState {
  final List<EntryModel> entries;
  final List<EntryModel> randomAnswers;
  final bool isShowAnswer;
  final int currentIndex;
  final int countAdded;
  final int countdown;
  final bool isPause;
  const PlayState({
    bool isLoading = false,
    String errorMessage = '',
    this.entries = const [],
    this.randomAnswers = const [],
    this.isShowAnswer = false,
    this.currentIndex = 0,
    this.countAdded = 0,
    this.countdown = 0,
    this.isPause = false,
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  PlayState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<EntryModel>? entries,
    List<EntryModel>? randomAnswers,
    bool? isShowAnswer,
    int? currentIndex,
    int? countAdded,
    int? countdown,
    bool? isPause,
  }) {
    return PlayState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      entries: entries ?? this.entries,
      randomAnswers: randomAnswers ?? this.randomAnswers,
      isShowAnswer: isShowAnswer ?? this.isShowAnswer,
      currentIndex: currentIndex ?? this.currentIndex,
      countAdded: countAdded ?? this.countAdded,
      countdown: countdown ?? this.countdown,
      isPause: isPause ?? this.isPause,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        entries,
        randomAnswers,
        isShowAnswer,
        currentIndex,
        countAdded,
        countdown,
        isPause,
      ];
}
