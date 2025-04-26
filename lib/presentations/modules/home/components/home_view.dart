import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/presentations/modules/home/cubit/home_cubit.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/primary_button.dart';

class HomeView extends BaseWidget<HomeCubit, HomeState> {
  const HomeView({super.key});

  @override
  void onInit(BuildContext context) {
    super.onInit(context);
  }

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    final cubit = context.read<HomeCubit>();
    final appCubit = context.read<AppCubit>();
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: theme.colors.black.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 2,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: AppBar(
              actions: [
                IconButton(
                  onPressed: () => cubit.showMenu(context),
                  icon: const Icon(Icons.menu, size: 32),
                ),
              ],
            ),
          ),
        ),
        body: PopScope(
          canPop: false,
          child: RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Hi ${appCubit.state.firebaseUser?.displayName}, Welcome to Meory",
                      style: AppTextStyle.s16bold.withColor(theme.colors.primaryText),
                    ),
                    const SizedBox(height: 100),
                    PrimaryButton(
                      title: 'Start quiz',
                      onTap: () {
                        //
                      },
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }

  onTapLogout() {
    AppSecureStorage.resetToken();
    AppNavigator.go(Routes.signIn);
  }

  /// tap Icon Add
  void onTapAdd() {
    debugPrint("Add Button pressed");
  }
}
