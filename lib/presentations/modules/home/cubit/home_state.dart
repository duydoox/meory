part of 'home_cubit.dart';

class HomeState extends CoreState {
  final HomeModel homeData;
  const HomeState({
    bool isLoading = false,
    String errorMessage = '',
    this.homeData = const HomeModel(),
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    int? pageIndex,
    HomeModel? homeData,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      homeData: homeData ?? this.homeData,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        homeData,
      ];
}
