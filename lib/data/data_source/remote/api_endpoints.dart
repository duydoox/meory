final class ApiEndpoints {
  ApiEndpoints._();

  static const String title = '/title';

  // AUTH
  static const String login = '/login';
  static const String sendEmail = '/send-otp';
  static const String vefifyOtp = '/vefify-otp';
  static const String firstPassword = '/first-password';

  // SELF ID
  static const String createSelfId = '/identifier/create/card';
  static const String updateSelfId = '/identifier/update/card';
  static const String createVerifier = '/identifier/create/verifier';

  static const String getHomeInfo = '/identifier/get-home-info';

  /// param {id}
  static const String getSelfIdDetail = '/identifier/card-info/{id}';
  static const String getListVerifier = '/identifier/list-verification';

  /// param {id}
  static const String deleteVerifier = '/identifier/delete/{id}/verifier';

  // SHARE
  static const String getLink = '/share/get-link';

  // VERIFY
  static const String getCardInfoVerify = '/verify/get-card-info';
  static const String getClanInfoVerify = '/verify/get-clan-info';
  static const String getTaekwondoInfoVerify = '/verify/get-taekwondo-info';
  static const String confirmVerify = '/verify/confirm';
  static const String rejectVerify = '/verify/reject';
  static const String verifySignature = '/verify/signature-info';

  // BANK
  static const String getListBank = '/bank-account/get-list';
  static const String getBankDetail = '/bank-account/detail/{id}';
  static const String addBank = '/bank-account/create';
  static const String updateBank = '/bank-account/update';
  static const String deleteBank = '/bank-account/delete/{id}';

  // CLAN
  static const String addClan = '/clan/create';
  static const String updateClan = '/clan/update';
  static const String getClanDetail = '/clan/detail/{id}';

  // CLAN
  static const String addTeakwondo = '/taekwondo/create/taekwondo';
  static const String updateTeakwondo = '/taekwondo/update/taekwondo';
  static const String getTeakwondoDetail = '/taekwondo/detail/taekwondo/{id}';

  // EVENT
  static const String getEventInfo = '/event/web/detail/{id}';

  // CATEGORY
  static const String getListCategory = '/category/list';
}
