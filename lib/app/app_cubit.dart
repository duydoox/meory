import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> with SuperAppConn {
  AppCubit() : super(const AppInitial());

  Future getLanguage() async {
    var languageLocal = await AppSP.get(AppSP.languageLocale);
    if (!Utils.isNullOrEmpty(languageLocal)) {
      emit(state.copyWith(locale: Locale(languageLocal)));
      onChangeLanguage(Locale(languageLocal));
    } else {
      onChangeLanguage(LanguageType.english.locale);
    }
  }

  void init(BuildContext context) async {
    await getLanguage();
    await initTheme();
    // WidgetUtils.configLoading(AppImages.icFullLogoWhite.assetName);
  }

  Future<void> initTheme() async {
    var themeMode = await AppSP.get(AppSP.themeMode);
    if (themeMode == null) {
      changeThemeMode(AppThemeMode.dark);
    } else {
      changeThemeMode(AppThemeMode.values.byName(themeMode));
    }
  }

  void changeThemeMode(AppThemeMode themeMode) {
    emit(state.copyWith(theme: AppTheme(themeMode), themeMode: themeMode));
    AppSP.set(AppSP.themeMode, themeMode.name);
  }

  void switchThemeMode() {
    if (state.themeMode == AppThemeMode.light) {
      emit(state.copyWith(
        themeMode: AppThemeMode.dark,
        theme: const AppTheme(AppThemeMode.dark),
      ));
    } else {
      emit(state.copyWith(
        themeMode: AppThemeMode.light,
        theme: const AppTheme(AppThemeMode.light),
      ));
    }
  }

  Future<void> changeUser(User? user) async {
    await AppSP.remove(AppSP.userId);
    await AppSP.set(AppSP.userId, user?.uid);
    emit(state.copyWith(firebaseUser: user));
  }

  // void configLoading() {
  //   EasyLoading.instance
  //     ..loadingStyle = EasyLoadingStyle.custom
  //     ..textColor = Colors.white
  //     ..radius = 10
  //     ..indicatorType = EasyLoadingIndicatorType.rotatingCircle
  //     ..indicatorColor = Colors.transparent
  //     ..userInteractions = false
  //     ..indicatorWidget = const BrandLoading(
  //       logoDark: false,
  //     )
  //     ..boxShadow = <BoxShadow>[]
  //     ..maskColor = Colors.black.withOpacity(0.6)
  //     ..backgroundColor = Colors.transparent
  //     ..maskType = EasyLoadingMaskType.custom
  //     ..dismissOnTap = false;
  // }

  /// Change Language
  Future<void> onChangeLanguage(Locale? lang) async {
    await AppSP.remove(AppSP.languageLocale);
    await AppSP.set(AppSP.languageLocale, lang?.languageCode);
    // switchThemeMode();
    emit(state.copyWith(locale: lang));
  }

  @override
  Future<dynamic> onEvent(MiniAppEvent event, [data]) async {
    if (event == MiniAppEvent.refreshToken) {
      // await BaseRepository().refreshToken();
      // final tokenData = await AppSecureStorage.getToken();
      // return tokenData?.accessToken;
    }
  }
}
