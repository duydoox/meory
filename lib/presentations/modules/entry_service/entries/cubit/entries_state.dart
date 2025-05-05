part of 'entries_cubit.dart';

class EntriesState extends CoreState {
  final List<EntryModel> entries;
  final List<EntryModel> entriesSearch;
  final bool isSearching;
  final bool isSearched;
  const EntriesState({
    bool isLoading = false,
    String errorMessage = '',
    this.entries = const [],
    this.entriesSearch = const [],
    this.isSearching = false,
    this.isSearched = false,
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  EntriesState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<EntryModel>? entries,
    List<EntryModel>? entriesSearch,
    bool? isSearching,
    bool? isSearched,
  }) {
    return EntriesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      entries: entries ?? this.entries,
      entriesSearch: entriesSearch ?? this.entriesSearch,
      isSearching: isSearching ?? this.isSearching,
      isSearched: isSearched ?? this.isSearched,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        entries,
        entriesSearch,
        isSearching,
        isSearched,
      ];
}
