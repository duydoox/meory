class AppSession {
  String _currentLanguage = 'vi';
  String? _imgEncToken;

  String get currentLanguage => _currentLanguage;
  String? get imgEncToken => _imgEncToken;

  static final AppSession _instance = AppSession._internal();

  factory AppSession() {
    return _instance;
  }
  AppSession._internal();

  void setCurrentLanguage(String currentLanguage) {
    _currentLanguage = currentLanguage;
  }

  void setImgEncToken(String? imgEncToken) {
    _imgEncToken = imgEncToken;
  }

  void clear() {
    _currentLanguage = 'vi';
    _imgEncToken = null;
  }
}
