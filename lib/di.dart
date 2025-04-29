import 'dart:io';

import 'package:core/core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:meory/data/repositories/auth/auth_repo_impl.dart';
import 'package:meory/data/repositories/entry/entry_repo_impl.dart';
import 'package:meory/data/repositories/openai/openai_repo_impl.dart';
import 'package:meory/data/repositories/splash/splash_repo_impl.dart';
import 'package:meory/data/repositories/statistical/statistical_repo_impl.dart';
import 'package:meory/domain/repositories/auth/auth_repo.dart';
import 'package:meory/domain/repositories/entry/entry_repo.dart';
import 'package:meory/domain/repositories/openai/openai_repo.dart';
import 'package:meory/domain/repositories/splash/splash_repo.dart';
import 'package:meory/domain/repositories/statistical/statistical_repo.dart';
import 'package:meory/domain/usecases/auth/change_password_usecase.dart';
import 'package:meory/domain/usecases/auth/login_usecase.dart';
import 'package:meory/domain/usecases/auth/send_email_usecase.dart';
import 'package:meory/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:meory/domain/usecases/entry/count_entries_usecase.dart';
import 'package:meory/domain/usecases/entry/count_mastered_usecase.dart';
import 'package:meory/domain/usecases/entry/create_entry_usecase.dart';
import 'package:meory/domain/usecases/entry/delete_entry_usecase.dart';
import 'package:meory/domain/usecases/entry/get_entries_usecase.dart';
import 'package:meory/domain/usecases/entry/get_entry_usecase.dart';
import 'package:meory/domain/usecases/entry/get_home_entries_usecase.dart';
import 'package:meory/domain/usecases/entry/update_entry_usecase.dart';
import 'package:meory/domain/usecases/openai/get_prompt_word_usecase.dart';
import 'package:meory/domain/usecases/splash/splash_usecase.dart';
import 'package:meory/domain/usecases/statistical/get_statistical_usecase.dart';
import 'package:meory/domain/usecases/statistical/update_statistical_usecase.dart';
import 'package:meory/presentations/service/play_service.dart';

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
    initService();
  }

  static void initRepo() {
    getIt.registerSingleton<SplashRepo>(SplashRepoImpl());
    getIt.registerSingleton<AuthRepo>(AuthRepoImpl());
    getIt.registerSingleton<EntryRepo>(EntryRepoImpl());
    getIt.registerSingleton<StatisticalRepo>(StatisticalRepoImpl());
    getIt.registerSingleton<OpenaiRepo>(OpenaiRepoImpl());
  }

  static void initUseCases() {
    getIt.registerSingleton<SplashUseCase>(SplashUseCase(getIt.get<SplashRepo>()));
    //auth
    getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt.get<AuthRepo>()));
    getIt.registerSingleton<SendEmailUseCase>(SendEmailUseCase(getIt.get<AuthRepo>()));
    getIt.registerSingleton<VerifyOtpUseCase>(VerifyOtpUseCase(getIt.get<AuthRepo>()));
    getIt.registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase(getIt.get<AuthRepo>()));

    //entry
    getIt.registerSingleton<CreateEntryUseCase>(CreateEntryUseCase(getIt.get<EntryRepo>()));
    getIt.registerSingleton<GetEntriesUseCase>(GetEntriesUseCase(getIt.get<EntryRepo>()));
    getIt.registerSingleton<GetEntryUseCase>(GetEntryUseCase(getIt.get<EntryRepo>()));
    getIt.registerSingleton<UpdateEntryUseCase>(UpdateEntryUseCase(getIt.get<EntryRepo>()));
    getIt.registerSingleton<DeleteEntryUseCase>(DeleteEntryUseCase(getIt.get<EntryRepo>()));
    getIt.registerSingleton<GetHomeEntriesUseCase>(GetHomeEntriesUseCase(getIt.get<EntryRepo>()));
    getIt.registerSingleton<CountEntriesUseCase>(CountEntriesUseCase(getIt.get<EntryRepo>()));
    getIt.registerSingleton<CountMasteredUseCase>(CountMasteredUseCase(getIt.get<EntryRepo>()));

    //statistical
    getIt.registerSingleton<GetStatisticalUseCase>(
        GetStatisticalUseCase(getIt.get<StatisticalRepo>()));
    getIt.registerSingleton<UpdateStatisticalUseCase>(
        UpdateStatisticalUseCase(getIt.get<StatisticalRepo>()));

    //openai
    getIt.registerSingleton<GetPromptWordUseCase>(GetPromptWordUseCase(getIt.get<OpenaiRepo>()));
  }

  static void initService() {
    getIt.registerSingleton<PlayService>(PlayService());
  }
}
