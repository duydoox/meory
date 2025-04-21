import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_ko.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko')
  ];

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'ID (email)'**
  String get account;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequired;

  /// No description provided for @emailFormat.
  ///
  /// In en, this message translates to:
  /// **'The email format is incorrect'**
  String get emailFormat;

  /// No description provided for @emailExists.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get emailExists;

  /// No description provided for @otpRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 4-digit verification code sent to your email'**
  String get otpRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the password you want to use'**
  String get passwordRequired;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @char.
  ///
  /// In en, this message translates to:
  /// **'character'**
  String get char;

  /// No description provided for @requireBothUpAndLowerCase.
  ///
  /// In en, this message translates to:
  /// **'Including uppercase and lowercase'**
  String get requireBothUpAndLowerCase;

  /// No description provided for @requireSpecial.
  ///
  /// In en, this message translates to:
  /// **'Contains special characters'**
  String get requireSpecial;

  /// No description provided for @requireConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter it again'**
  String get requireConfirmPassword;

  /// No description provided for @passwordMatching.
  ///
  /// In en, this message translates to:
  /// **'Password match'**
  String get passwordMatching;

  /// No description provided for @finishSigup.
  ///
  /// In en, this message translates to:
  /// **'Your registration has been completed!'**
  String get finishSigup;

  /// No description provided for @goToHome.
  ///
  /// In en, this message translates to:
  /// **'Go to home'**
  String get goToHome;

  /// No description provided for @infoRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your information'**
  String get infoRequired;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter'**
  String get pleaseEnter;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'male'**
  String get male;

  /// No description provided for @verifycationRequest.
  ///
  /// In en, this message translates to:
  /// **'Verifycation Request'**
  String get verifycationRequest;

  /// No description provided for @pleaseAddVerifier.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one verifier'**
  String get pleaseAddVerifier;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get pleaseFillAllFields;

  /// No description provided for @certification.
  ///
  /// In en, this message translates to:
  /// **'Certification'**
  String get certification;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get personalInfo;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileNumber;

  /// No description provided for @bankAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Bank account number'**
  String get bankAccountNumber;

  /// No description provided for @pleaseEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your mobile phone number'**
  String get pleaseEnterPhone;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @myInformation.
  ///
  /// In en, this message translates to:
  /// **'My information'**
  String get myInformation;

  /// No description provided for @coating.
  ///
  /// In en, this message translates to:
  /// **'Clan'**
  String get coating;

  /// No description provided for @taekwondo.
  ///
  /// In en, this message translates to:
  /// **'Taekwondo'**
  String get taekwondo;

  /// No description provided for @bankAccount.
  ///
  /// In en, this message translates to:
  /// **'Bank account'**
  String get bankAccount;

  /// No description provided for @accountRegisted.
  ///
  /// In en, this message translates to:
  /// **'Your account has been registered!'**
  String get accountRegisted;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @requesterList.
  ///
  /// In en, this message translates to:
  /// **'Requester List'**
  String get requesterList;

  /// No description provided for @certifierList.
  ///
  /// In en, this message translates to:
  /// **'Certifier list'**
  String get certifierList;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @refusal.
  ///
  /// In en, this message translates to:
  /// **'Refusal'**
  String get refusal;

  /// No description provided for @approval.
  ///
  /// In en, this message translates to:
  /// **'Approval'**
  String get approval;

  /// No description provided for @refusalSuccess.
  ///
  /// In en, this message translates to:
  /// **'Refusal success'**
  String get refusalSuccess;

  /// No description provided for @approvalSuccess.
  ///
  /// In en, this message translates to:
  /// **'Approval success'**
  String get approvalSuccess;

  /// No description provided for @pleaseSelectBank.
  ///
  /// In en, this message translates to:
  /// **'Please select a bank'**
  String get pleaseSelectBank;

  /// No description provided for @pleaseEnterAccount.
  ///
  /// In en, this message translates to:
  /// **'Please enter your account'**
  String get pleaseEnterAccount;

  /// No description provided for @accountList.
  ///
  /// In en, this message translates to:
  /// **'Account List'**
  String get accountList;

  /// No description provided for @accountRegistration.
  ///
  /// In en, this message translates to:
  /// **'Register account'**
  String get accountRegistration;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @ruler.
  ///
  /// In en, this message translates to:
  /// **'Ruler'**
  String get ruler;

  /// No description provided for @like.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get like;

  /// No description provided for @surname.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surname;

  /// No description provided for @greenOnion.
  ///
  /// In en, this message translates to:
  /// **'Green Onion'**
  String get greenOnion;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ko': return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
