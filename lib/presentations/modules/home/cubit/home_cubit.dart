import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/data/models/home/home_model.dart';
import 'package:meory/data/models/statistical_week/statistical_day_model.dart';
import 'package:meory/data/models/statistical_week/statistical_model.dart';
import 'package:meory/domain/usecases/entry/count_entries_usecase.dart';
import 'package:meory/domain/usecases/entry/count_mastered_usecase.dart';
import 'package:meory/domain/usecases/statistical/get_list_statistical_by_day_usecase.dart';
import 'package:meory/domain/usecases/statistical/get_statistical_usecase.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';

part 'home_state.dart';

class HomeCubit extends CoreCubit<HomeState> {
  final _countEntriesUseCase = getIt<CountEntriesUseCase>();
  final _countMasteredUseCase = getIt<CountMasteredUseCase>();
  final _getStatisticalUseCase = getIt<GetStatisticalUseCase>();
  final _getListStatisticByDay = getIt<GetListStatisticalByDayUseCase>();
  HomeCubit() : super(const HomeState());

  static bool neededRefreshData = false;

  Future<void> getHomeData() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = _countEntriesUseCase.execute();
    final masteredResult = _countMasteredUseCase.execute();
    final statisticalResult = _getStatisticalUseCase.execute();
    final listStatisticalResult = _getListStatisticByDay.execute(
      startDate: DateTime.now().subtract(const Duration(days: 7)),
      endDate: DateTime.now(),
    );
    final data = await Future.wait([
      result,
      masteredResult,
      statisticalResult,
      listStatisticalResult,
    ]);
    if (data.every((element) => element.isSuccess)) {
      emit(
        state.copyWith(
          isLoading: false,
          homeData: state.homeData.copyWith(
            totalEntries: (data[0].data as int?) ?? state.homeData.totalEntries,
            masteredEntries: (data[1].data as int?) ?? state.homeData.masteredEntries,
          ),
          statisticalModel: (data[2].data as StatisticalModel?) ?? state.statisticalModel,
          listStatisticalByDay: (data[3].data as List<StatisticalDayModel>?) ?? [],
        ),
      );
    } else {
      debugPrint('Error: ${data[0].error ?? data[1].error ?? data[2].error}');
      emit(state.copyWith(
        isLoading: false,
        homeData: const HomeModel(),
        errorMessage: data[0].error ?? data[1].error ?? data[2].error,
      ));
    }
  }

  void showMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (c) {
        final theme = context.read<AppCubit>().state.theme;
        final tr = Utils.languageOf(context);
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    tr.setting,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.s16w600.withColor(theme.colors.blackText),
                  ),
                  onTap: onTapSetting,
                ),
                Divider(color: theme.colors.divider, height: 1),
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    tr.logOut,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.s16w600.withColor(theme.colors.red),
                  ),
                  onTap: onTapLogout,
                ),
                PrimaryButton(
                  title: tr.close,
                  onTap: () {
                    AppNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onTapSetting() {
    AppNavigator.push(Routes.setting);
  }

  onTapLogout() {
    FirebaseAuth.instance.signOut().then((value) => AppNavigator.go(Routes.auth));
  }
}
