import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meory/presentations/modules/auth_service/auth/auth_screen.dart';
import 'package:meory/presentations/modules/auth_service/change_password/change_password_screen.dart';
import 'package:meory/presentations/modules/auth_service/otp/otp_screen.dart';
import 'package:meory/presentations/modules/auth_service/sign_in/sign_in_screen.dart';
import 'package:meory/presentations/modules/auth_service/sign_up/sign_up_screen.dart';
import 'package:meory/presentations/modules/auth_service/sign_up_completed/sign_up_completed_screen.dart';
import 'package:meory/presentations/modules/auth_service/sign_up_with_email/sign_up_with_email_screen.dart';
import 'package:meory/presentations/modules/home/home_screen.dart';
import 'package:meory/presentations/modules/splash/splash_screen.dart';

enum Routes {
  splash('/'),
  home('/home'),
  requesterList('/requesterList'),
  // auth
  auth('/auth'),
  signUp('/sign_up'),
  signIn('/sign_in'),
  signUpCompleted('/sign_up_completed'),
  signUpWithEmail('/sign_up_with_email'),
  changePassword('/change_password'),
  otp('/otp'),
  ;

  final String path;

  const Routes(this.path);
}

final class _RouteConfig {
  static final List<RouteBase> routes = [
    GoRoute(
      path: Routes.splash.path,
      pageBuilder: (context, state) => getPage(
        page: const SplashScreen(),
        state: state,
      ),
    ),
    GoRoute(
      path: Routes.auth.path,
      pageBuilder: (context, state) => getPage(
        page: const AuthScreen(),
        state: state,
      ),
    ),
    GoRoute(
      path: Routes.signUp.path,
      pageBuilder: (context, state) => getPage(
        page: const SignUpScreen(),
        state: state,
      ),
    ),
    GoRoute(
      path: Routes.changePassword.path,
      pageBuilder: (context, state) => getPage(
        page: const ChangePasswordScreen(),
        state: state,
      ),
    ),
    GoRoute(
      path: Routes.otp.path,
      pageBuilder: (context, state) => getPage(
        page: const OtpScreen(),
        state: state,
      ),
    ),
    GoRoute(
      path: Routes.signUpCompleted.path,
      pageBuilder: (context, state) => getPage(
        page: const SignUpCompletedScreen(),
        state: state,
      ),
    ),
    GoRoute(
      path: Routes.signUpWithEmail.path,
      pageBuilder: (context, state) => getPage(
        page: const SignUpWithEmailScreen(),
        state: state,
      ),
    ),
    GoRoute(
      path: Routes.signIn.path,
      pageBuilder: (context, state) => getPage(
        page: const SignInScreen(),
        state: state,
      ),
    ),
    GoRoute(
      path: Routes.home.path,
      pageBuilder: (context, state) => getPage(
        page: const HomeScreen(),
        state: state,
      ),
    ),
  ];

  static final ValueNotifier<RoutingConfig> config = ValueNotifier(RoutingConfig(routes: routes));

  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static final GoRouter router = GoRouter.routingConfig(
    routingConfig: config,
    observers: [routeObserver],
    navigatorKey: AppNavigator.navigatorKey,
  );

  static String of(Routes route) => route.path;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static bool isLoadedSplash = false;

  static final GoRouter router = _RouteConfig.router;

  static final RouteObserver<PageRoute> routeObserver = _RouteConfig.routeObserver;

  static String get initialRoute => _RouteConfig.of(Routes.splash);

  static void addRoutes(List<RouteBase> routes) {
    _RouteConfig.config.value = RoutingConfig(
      routes: _RouteConfig.routes + routes,
    );
  }

  static void replaceRoutes(List<RouteBase> routes) {
    _RouteConfig.config.value = RoutingConfig(
      routes: routes,
    );
  }

  static Future pushNamed<T extends Object>(String route, [T? arguments]) async =>
      context.push(route, extra: arguments);

  static void replaceNamed<T extends Object>(String route, [T? arguments]) =>
      context.replace(route, extra: arguments);

  static void goNamed<T extends Object>(String route, [T? arguments]) =>
      context.go(route, extra: arguments);

  static Future push<T extends Object>(Routes route, [T? arguments]) async =>
      pushNamed(_RouteConfig.of(route), arguments);

  static void replace<T extends Object>(Routes route, [T? arguments]) =>
      replaceNamed(_RouteConfig.of(route), arguments);

  static void go<T extends Object>(Routes route, [T? arguments]) =>
      goNamed(_RouteConfig.of(route), arguments);

  static void pop<T extends Object>([T? result]) => context.pop(result);

  static BuildContext get context {
    if (navigatorKey.currentContext == null) {
      throw Exception('Navigator is not initialized');
    }

    return navigatorKey.currentContext!;
  }
}
