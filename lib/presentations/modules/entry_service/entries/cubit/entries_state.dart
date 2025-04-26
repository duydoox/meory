part of 'entries_cubit.dart';

class EntriesState extends CoreState {
  final List<EntryModel> entries;
  const EntriesState({
    bool isLoading = false,
    String errorMessage = '',
    this.entries = const [],
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  EntriesState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<EntryModel>? entries,
  }) {
    return EntriesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      entries: entries ?? this.entries,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        entries,
      ];
}
