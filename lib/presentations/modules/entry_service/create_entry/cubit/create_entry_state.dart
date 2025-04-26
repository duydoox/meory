part of 'create_entry_cubit.dart';

class CreateEntryState extends CoreState {
  const CreateEntryState({
    bool isLoading = false,
    String errorMessage = '',
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  CreateEntryState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return CreateEntryState(
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
