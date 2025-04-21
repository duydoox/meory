import 'dart:io';

import 'package:meory/data/repositories/auth/auth_repo_impl.dart';
import 'package:meory/data/repositories/splash/splash_repo_impl.dart';
import 'package:meory/domain/repositories/auth/auth_repo.dart';
import 'package:meory/domain/repositories/splash/splash_repo.dart';
import 'package:meory/domain/usecases/auth/change_password_usecase.dart';
import 'package:meory/domain/usecases/auth/login_usecase.dart';
import 'package:meory/domain/usecases/auth/send_email_usecase.dart';
import 'package:meory/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:meory/domain/usecases/splash/splash_usecase.dart';
import 'package:core/core.dart';
import 'package:device_info_plus/device_info_plus.dart';

final class DependencyInjection {
  static Future<void> init() async {
    await Di().init();

    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      getIt.registerSingleton<AndroidDeviceInfo>(androidDeviceInfo);
    }

    if (Platform.isIOS) {
      final iOSDeviceInfo = await deviceInfoPlugin.iosInfo;
      getIt.registerSingleton<IosDeviceInfo>(iOSDeviceInfo);
    }

    initRepo();
    initUseCases();
  }

  static void initRepo() {
    getIt.registerSingleton<SplashRepo>(SplashRepoImpl());
    getIt.registerSingleton<AuthRepo>(AuthRepoImpl());
  }

  static void initUseCases() {
    getIt.registerSingleton<SplashUseCase>(SplashUseCase(getIt.get<SplashRepo>()));
    //auth
    getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt.get<AuthRepo>()));
    getIt.registerSingleton<SendEmailUseCase>(SendEmailUseCase(getIt.get<AuthRepo>()));
    getIt.registerSingleton<VerifyOtpUseCase>(VerifyOtpUseCase(getIt.get<AuthRepo>()));
    getIt.registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase(getIt.get<AuthRepo>()));
  }
}
