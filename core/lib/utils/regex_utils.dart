part of '../core.dart';

class RegexUtils {

  static const String username = r'^.{3,}$';
  static const String password = r'^.{8,}$';
  static const String email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phoneNumber = r'(^(?:[+0]9)?0[0-9]{9}$)';

  static bool isUsernameValid(String userName) {
    RegExp regExp = RegExp(username);
    //RegExp regExp = RegExp(r'^[a-zA-Z0-9]{3,}$');
    return regExp.hasMatch(userName);
  }

  static bool isPasswordValid(String pw) {
    RegExp regExp = RegExp(password);
    //RegExp regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}$');
    return regExp.hasMatch(pw);
  }

  static bool isEmailValid(String email) {
    RegExp regExp = RegExp(email);
    return regExp.hasMatch(email);
  }

  static bool isPhoneNumberValid(String phoneNo) {
    RegExp regExp = RegExp(phoneNumber);
    return regExp.hasMatch(phoneNo);
  }
}
