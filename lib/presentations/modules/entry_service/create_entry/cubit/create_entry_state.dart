part of 'create_entry_cubit.dart';

class CreateEntryState extends CoreState {
  final List<EntryModel> prompts;
  const CreateEntryState({
    bool isLoading = false,
    String errorMessage = '',
    this.prompts = const [],
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  CreateEntryState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<EntryModel>? prompts,
  }) {
    return CreateEntryState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      prompts: prompts ?? this.prompts,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        prompts,
      ];
}
