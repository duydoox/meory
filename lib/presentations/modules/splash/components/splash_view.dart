part of '../splash_screen.dart';

class SplashView extends BaseWidget<SplashCubit, SplashState> {
  const SplashView({super.key});

  @override
  void onInit(BuildContext context) {
    super.onInit(context);

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   context.read<SplashCubit>().init();
    // });

    Future.delayed(const Duration(seconds: 2), () {
      AppNavigator.isLoadedSplash = true;

      AppCubit appCubit = context.read<AppCubit>();
      if (appCubit.state.firebaseUser?.emailVerified == true) {
        AppNavigator.go(Routes.home);
      } else {
        AppNavigator.isLoadedSplash = true;
        AppNavigator.go(Routes.auth);
      }
    });
  }

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 104.dg,
              width: 215.dg,
              child: Assets.images.icLogo.image(),
            ),
            const SizedBox(height: 28),
            // const LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
