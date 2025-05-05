import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meory/presentations/modules/uni_links/uni_app.dart';

import 'app/app_cubit.dart';
import 'configs.dart';
import 'di.dart';
import 'presentations/routes.dart';
import 'presentations/service/tts_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['assets', 'fonts'], license);
  });
  await dotenv.load();
  await DependencyInjection.init();
  Configs.configEnvironment();
  TtsService().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: const AppMobile(),
    );
  }
}

class AppMobile extends StatefulWidget {
  const AppMobile({super.key});

  @override
  State<AppMobile> createState() => _AppMobileState();
}

class _AppMobileState extends State<AppMobile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AppCubit appCubit = context.read<AppCubit>();
      appCubit.init(context);
      // appCubit.configLoading();
    });
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      AppCubit appCubit = context.read<AppCubit>();
      appCubit.changeUser(firebaseUser);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(437, 972), // Design size of Redmi Note 12 Turbo
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) =>
            previous.locale != current.locale || previous.firebaseUser != current.firebaseUser,
        builder: (context, state) {
          final colors = context.watch<AppCubit>().state.theme.colors;

          return MaterialApp.router(
            scaffoldMessengerKey: AppNavigator.scaffoldMessengerKey,
            color: colors.white,
            title: '',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: state.themeMode == AppThemeMode.light ? ThemeMode.light : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
              child: UniApp(
                child: EasyLoading.init()(context, child!),
              ),
            ),
            locale: state.locale,
            routerConfig: AppNavigator.router,
          );
        },
      ),
    );
  }
}
