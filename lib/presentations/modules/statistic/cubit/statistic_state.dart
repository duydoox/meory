part of 'statistic_cubit.dart';

class StatisticState extends CoreState {
  const StatisticState({
    bool isLoading = false,
    String errorMessage = '',
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  StatisticState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return StatisticState(
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
