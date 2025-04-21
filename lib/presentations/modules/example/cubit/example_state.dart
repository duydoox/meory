part of 'example_cubit.dart';

class ExampleState extends CoreState {
  const ExampleState({
    bool isLoading = false,
    String errorMessage = '',
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  ExampleState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return ExampleState(
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
