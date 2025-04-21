part of core;

class AppTextTheme {
  const AppTextTheme._({
    required this.h6,
    required this.h10,
    required this.h20,
    required this.h30,
    required this.h40,
    required this.h50,
    required this.h60,
    required this.h70,
    required this.h80,
  });

  factory AppTextTheme() {
    const normalRegular = TextStyle(
      fontWeight: FontWeight.w400,
      height: 1.5,
      leadingDistribution: TextLeadingDistribution.even,
      color: Color(0xFF323E44),
      fontFamily: "BeVietnamPro",
    );
    return AppTextTheme._(
      h6: const TextStyle(fontSize: 6).merge(normalRegular),
      h10: const TextStyle(fontSize: 10).merge(normalRegular),
      h20: const TextStyle(fontSize: 12).merge(normalRegular),
      h30: const TextStyle(fontSize: 14).merge(normalRegular),
      h40: const TextStyle(fontSize: 16).merge(normalRegular),
      h50: const TextStyle(fontSize: 20).merge(normalRegular),
      h60: const TextStyle(fontSize: 24).merge(normalRegular),
      h70: const TextStyle(fontSize: 32).merge(normalRegular),
      h80: const TextStyle(fontSize: 40).merge(normalRegular),
    );
  }

  /// pt6
  final TextStyle h6;

  /// pt10
  final TextStyle h10;

  /// pt12
  final TextStyle h20;

  /// pt14
  final TextStyle h30;

  /// pt16
  final TextStyle h40;

  /// pt20
  final TextStyle h50;

  /// pt24
  final TextStyle h60;

  /// pt32
  final TextStyle h70;

  /// pt40
  final TextStyle h80;
}

extension TextStyleExt on TextStyle {
  TextStyle bold() => copyWith(fontWeight: FontWeight.w600);

  TextStyle italic() => copyWith(fontStyle: FontStyle.italic);

  TextStyle underline() => copyWith(decoration: TextDecoration.underline);

  TextStyle setFont(FontWeight font) => copyWith(fontWeight: font);

  TextStyle setColor(Color color) => copyWith(color: color);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle setHeight(double height) => copyWith(height: height);

  TextStyle setFontWeight(FontWeight fontWeight) =>
      copyWith(fontWeight: fontWeight);

  TextStyle withFontWeight(FontWeight fontWeight) =>
      copyWith(fontWeight: fontWeight);

  TextStyle comfort() => copyWith(height: 1.8);

  TextStyle dense() => copyWith(height: 1.2);

// TextStyle rotunda() => copyWith(fontFamily: FontFamily.rotunda);
}

class AppTextStyle {

  /// THIS IS Font Nunito Sans
  /// SIZE 10
  static TextStyle s10w400 = GoogleFonts.nunitoSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  /// SIZE 12
  static TextStyle s12w400 = GoogleFonts.nunitoSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s12w600 = GoogleFonts.nunitoSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s12bold = GoogleFonts.nunitoSans(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle s13w600 = GoogleFonts.nunitoSans(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  /// SIZE 14
  static TextStyle s14w400 = GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s14w500 = GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle s14w600 = GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s14bold = GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// SIZE 16
  static TextStyle s16w400 = GoogleFonts.nunitoSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s16w500 = GoogleFonts.nunitoSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle s16w600 = GoogleFonts.nunitoSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s16w700 = GoogleFonts.nunitoSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle s16bold = GoogleFonts.nunitoSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// SIZE 18
  static TextStyle s18w400 = GoogleFonts.nunitoSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s18w600 = GoogleFonts.nunitoSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s18bold = GoogleFonts.nunitoSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// SIZE 20
  static TextStyle s20w400 = GoogleFonts.nunitoSans(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s20w500 = GoogleFonts.nunitoSans(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle s20w600 = GoogleFonts.nunitoSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s20w700 = GoogleFonts.nunitoSans(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle s20bold = GoogleFonts.nunitoSans(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// SIZE 24
  static TextStyle s24w500 = GoogleFonts.nunitoSans(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle s24w600 = GoogleFonts.nunitoSans(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  /// SIZE 28
  static TextStyle s28w600 = GoogleFonts.nunitoSans(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  /// SIZE 32
  static TextStyle s32w700 = GoogleFonts.nunitoSans(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  /// SIZE 40
  static TextStyle s40w700 = GoogleFonts.nunitoSans(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle s40w800 = GoogleFonts.nunitoSans(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );


/// THIS IS Font Clash Display
  static TextStyle s10w400CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  /// SIZE 12
  static TextStyle s12w400CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s12w600CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s12boldCD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle s13w600CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  /// SIZE 14
  static TextStyle s14w400CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s14w500CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle s14w600CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s14boldCD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// SIZE 16
  static TextStyle s16w400CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s16w500CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle s16w600CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s16w700CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle s16boldCD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// SIZE 18
  static TextStyle s18w400CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s18w600CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s18boldCD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// SIZE 20
  static TextStyle s20w400CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle s20w500CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle s20w600CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle s20w700CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle s20boldCD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// SIZE 24
  static TextStyle s24w500CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle s24w600CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  /// SIZE 28
  static TextStyle s28w600CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  /// SIZE 32
  static TextStyle s32w700CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  /// SIZE 40
  static TextStyle s40w700CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle s40w800CD = const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );
}
