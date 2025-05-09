part of 'create_entry_cubit.dart';

class CreateEntryState extends CoreState {
  final List<EntryModel> prompts;
  final List<EntryModel> entriesExist;
  const CreateEntryState({
    bool isLoading = false,
    String errorMessage = '',
    this.prompts = const [],
    this.entriesExist = const [],
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  CreateEntryState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<EntryModel>? prompts,
    List<EntryModel>? entriesExist,
  }) {
    return CreateEntryState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      prompts: prompts ?? this.prompts,
      entriesExist: entriesExist ?? this.entriesExist,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        prompts,
        entriesExist,
      ];
}
