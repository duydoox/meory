part of 'home_cubit.dart';

class HomeState extends CoreState {
  final HomeModel homeData;
  final StatisticalModel statisticalModel;
  final List<StatisticalDayModel> listStatisticalByDay;
  const HomeState({
    bool isLoading = false,
    String errorMessage = '',
    this.homeData = const HomeModel(),
    this.statisticalModel = const StatisticalModel(),
    this.listStatisticalByDay = const [],
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
    StatisticalModel? statisticalModel,
    List<StatisticalDayModel>? listStatisticalByDay,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      homeData: homeData ?? this.homeData,
      statisticalModel: statisticalModel ?? this.statisticalModel,
      listStatisticalByDay: listStatisticalByDay ?? this.listStatisticalByDay,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        homeData,
        statisticalModel,
        listStatisticalByDay,
      ];
}
