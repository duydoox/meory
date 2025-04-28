part of 'entry_detail_cubit.dart';

class EntryDetailState extends CoreState {
  const EntryDetailState({
    bool isLoading = false,
    String errorMessage = '',
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  EntryDetailState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return EntryDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
      ];
}
