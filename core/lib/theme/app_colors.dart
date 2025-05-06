part of '../core.dart';

class AppColors {
  final Color background;
  final Color white;
  final Color black;
  final Color primary;
  final Color grey;
  final Color red;
  final Color green;
  final Color greyBackground;
  final Color greyBackground2;
  final Color inputBackground;
  final Color blueBackground;
  final Color alertBackground;
  final Color hintText;
  final Color brown;
  final Color greenEnable;
  final Color orange;
  final Color yellow;

  /// Text ---
  final Color whiteText;
  final Color blackText;
  final Color primaryText;
  final Color secondaryText;
  final Color greyText;
  final Color blueText;
  final Color greenText;

  /// ---

  /// Border ---
  final Color border;

  ///  ---
  ///  Divider ---
  final Color divider;

  ///  ---
  const AppColors({
    required this.background,
    required this.white,
    required this.black,
    required this.whiteText,
    required this.blackText,
    required this.primaryText,
    required this.secondaryText,
    required this.greyText,
    required this.primary,
    required this.border,
    required this.divider,
    required this.grey,
    required this.greyBackground,
    required this.greyBackground2,
    required this.inputBackground,
    required this.blueText,
    required this.red,
    required this.green,
    required this.greenText,
    required this.blueBackground,
    required this.alertBackground,
    required this.hintText,
    required this.brown,
    required this.greenEnable,
    required this.orange,
    required this.yellow,
  });

  factory AppColors.light() {
    return const AppColors(
      background: Color(0xffffffff),
      white: Color(0xffffffff),
      black: Colors.black,
      green: Colors.green,
      greenText: Colors.green,
      whiteText: Color(0xffffffff),
      blackText: Colors.black,
      primary: Color(0xffD66DD3),
      primaryText: Color(0xffD66DD3),
      secondaryText: Color(0xffffffff),
      greyText: Color(0xff9E9E9E),
      border: Color(0xffEEEEEE),
      divider: Color(0xffCDCDCD),
      grey: Colors.grey,
      greyBackground: Color(0xffF8F8F8),
      greyBackground2: Color(0xffE4E4E4),
      inputBackground: Color(0xffF2F2F2),
      blueText: Colors.blue,
      red: Color(0xffF84646),
      blueBackground: Color(0xffDEF2FF),
      alertBackground: Color(0xff424242),
      hintText: Color(0xff888888),
      brown: Color(0xffB7A1A1),
      greenEnable: Color(0xff0CE39D),
      orange: Color(0xffFFA500),
      yellow: Color(0xffF7F800),
    );
  }
  factory AppColors.dark() {
    return const AppColors(
      background: Color(0xffffffff),
      white: Color(0xffffffff),
      black: Colors.black,
      whiteText: Color(0xffffffff),
      blackText: Colors.black,
      primary: Color(0xffD66DD3),
      primaryText: Color(0xffD66DD3),
      secondaryText: Color(0xffffffff),
      greyText: Color(0xff9E9E9E),
      border: Color(0xffEEEEEE),
      divider: Color(0xffCDCDCD),
      grey: Colors.grey,
      greyBackground: Color(0xffF8F8F8),
      greyBackground2: Color(0xffE4E4E4),
      inputBackground: Color(0xffF2F2F2),
      blueText: Colors.blue,
      red: Color(0xffF84646),
      green: Colors.green,
      greenText: Colors.green,
      blueBackground: Color(0xffDEF2FF),
      alertBackground: Color(0xff424242),
      hintText: Color(0xff888888),
      brown: Color(0xffB7A1A1),
      greenEnable: Color(0xff0CE39D),
      orange: Color(0xffFFA500),
      yellow: Color(0xffF7F800),
    );
  }
}
