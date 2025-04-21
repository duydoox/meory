part of '../core.dart';

class Utils {
  static const defaultPageSize = 30;

  /// Full screen size
  static Size getSize(BuildContext context) => MediaQuery.of(context).size;

  /// Full screen width and height
  static double getWidth(BuildContext context) => MediaQuery.of(context).size.width;

  static double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

  static double minEdgeInsets(BuildContext context) {
    final width = getWidth(context);
    final height = getHeight(context);
    return width < height ? width : height;
  }

  static double maxEdgeInsets(BuildContext context) {
    final width = getWidth(context);
    final height = getHeight(context);
    return width > height ? width : height;
  }

  /// Height (without SafeArea)
  static EdgeInsets getPadding(BuildContext context) => MediaQuery.of(context).viewPadding;

  /// Height statusBar
  static double getHeightStatusBar(BuildContext context) {
    final padding = MediaQuery.of(context).viewPadding;
    return padding.top;
  }

  static double getHeight1(BuildContext context) {
    final padding = MediaQuery.of(context).viewPadding;
    return MediaQuery.of(context).size.height - padding.top - padding.bottom;
  }

  /// Height (without status bar)
  static double getHeight2(BuildContext context) {
    final padding = MediaQuery.of(context).viewPadding;
    return MediaQuery.of(context).size.height - padding.top;
  }

  /// Height (without status and toolbar)
  static double getHeight3(BuildContext context) {
    final padding = MediaQuery.of(context).viewPadding;
    return MediaQuery.of(context).size.height - padding.top - kToolbarHeight;
  }

  static AppLocalizations languageOf(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static isNullOrEmpty(dynamic object) {
    if (object == null) {
      return true;
    }
    if (object is String && (object.isEmpty || (object.isNotEmpty && object.trim() == ""))) {
      return true;
    }
    if (object is List && object.isEmpty) {
      return true;
    }
    if (object is bool && object == false) {
      return true;
    }
    return false;
  }

  static Future<String> getEncryptToken() async {
    try {
      final tokenData = await AppSecureStorage.getToken();
      final secretKey = tokenData?.secretKey;
      final accessToken = tokenData?.accessToken;

      if (secretKey == null || accessToken == null) return '';
      final publicKey = '-----BEGIN PUBLIC KEY-----\n$secretKey\n-----END PUBLIC KEY-----';
      final tokenParts = accessToken.split('.');
      final data = "${tokenParts[0]}.${tokenParts[1]}";
      final encrypted = await RSA.encryptPKCS1v15(data, publicKey);

      return '$encrypted.${tokenParts[2]}';
    } catch (e) {
      Log.e(e.toString());
      return '';
    }
  }

  //count noti on doctor_home screen
  static String getCountNotify(int count) {
    if (count < 100) {
      return "$count";
    }
    return "99+";
  }

  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static double parseDouble(dynamic value) {
    return (value is int) ? (value).toDouble() : value;
  }
}
