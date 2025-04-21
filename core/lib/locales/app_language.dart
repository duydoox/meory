part of '../core.dart';

class AppLanguage {
  final int? id;
  final String? name;
  final String? languageCode;
  final Locale? locale;

  AppLanguage({this.id, this.name, this.languageCode, this.locale});

  static List<AppLanguage> languageList() {
    return AppLocalizations.supportedLocales.map((e) {
      final id = AppLocalizations.supportedLocales.indexOf(e);
      final name = e.languageCode.toUpperCase();
      final languageCode = e.languageCode;
      return AppLanguage(
          id: id, name: name, languageCode: languageCode, locale: Locale(e.languageCode));
    }).toList();
  }

  static void changeLanguage(BuildContext context, String languageCode) {}
}

class LanguageType {
  static AppLanguage english = AppLanguage(
    name: 'English',
    locale: const Locale('en'),
    languageCode: 'en',
  );
  static AppLanguage korea = AppLanguage(
    name: '한국어',
    locale: const Locale('ko'),
    languageCode: 'ko',
  );
  static List<AppLanguage> all = [
    english,
    korea,
  ];

  static List<AppLanguage> list(Locale? locale) {
    List<AppLanguage> langList = [];
    for (int i = 0; i < all.length; i++) {
      if (locale != null) {
        if (all[i].locale?.languageCode != locale.languageCode) {
          langList = [...langList, all[i]];
        }
      } else {
        langList = [...langList, all[i]];
      }
    }
    return langList;
  }

  static AppLanguage lang(Locale locale) {
    for (int i = 0; i < all.length; i++) {
      if (all[i].locale?.languageCode == locale.languageCode) {
        return all[i];
      }
    }
    return all[0];
  }

  static AppLanguage langByCode(String code) {
    for (int i = 0; i < all.length; i++) {
      if (all[i].locale?.languageCode == code) {
        return all[i];
      }
    }
    return all[0];
  }

  static AppLanguage langByName(String name) {
    for (int i = 0; i < all.length; i++) {
      if (all[i].name == name) {
        return all[i];
      }
    }
    return all[0];
  }
}
