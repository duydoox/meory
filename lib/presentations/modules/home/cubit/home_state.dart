part of 'home_cubit.dart';

class HomeState extends CoreState {
  final int pageIndex;
  const HomeState({
    bool isLoading = false,
    String errorMessage = '',
    this.pageIndex = 0,
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    int? pageIndex,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  List<Object?> get props => [
        pageIndex,
        isLoading,
        errorMessage,
      ];
}
