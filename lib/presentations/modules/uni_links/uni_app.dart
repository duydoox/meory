import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meory/presentations/routes.dart';
import 'package:uni_links/uni_links.dart';

class UniApp extends StatefulWidget {
  final Widget child;
  const UniApp({super.key, required this.child});

  @override
  State<UniApp> createState() => _UniAppState();
}

class _UniAppState extends State<UniApp> {
  static const String scheme = 'base';
  static const String host = 'app';

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      navigate(initialLink);

      linkStream.listen((String? link) {
        navigate(link);
      }, onError: (err) {
        // Handle exception by warning the user their action did not succeed
      });
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  navigate(String? link) async {
    final tokenData = await AppSecureStorage.getToken();
    if (Utils.isNullOrEmpty(tokenData?.accessToken)) {
      return;
    }
    if (!AppNavigator.isLoadedSplash) {
      await Future.delayed(const Duration(milliseconds: 1500));
    }
    if (link != null && link.startsWith('$scheme://$host/')) {
      final path = link.replaceAll('$scheme://$host/', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
