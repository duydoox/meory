// ignore_for_file: constant_identifier_names

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ErrorHandler {
  static ErrorHandler? _instance;

  factory ErrorHandler() {
    _instance ??= ErrorHandler._internal();
    return _instance!;
  }

  ErrorHandler._internal();

  bool loadError(DioException error) {
    // final context = AppNavigator.context;
    // final tr = Utils.languageOf(context);
    WidgetUtils.dismissLoading();
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        break;
      case DioExceptionType.badResponse:
        WidgetUtils.dismissLoading();
        break;
      case DioExceptionType.cancel:
        Log.e('Request to API server was cancelled');
        break;
      case DioExceptionType.connectionError:
        WidgetUtils.dismissLoading();
        return true;
      default:
        break;
    }
    WidgetUtils.dismissLoading();
    return false;
  }

  String handleError(DioException e) {
    if (kDebugMode && e.response is String) {
      return e.response.toString();
    }
    if (e.response?.data is String && !Utils.isNullOrEmpty(e.response?.data)) {
      return kDebugMode ? e.response?.data : ErrorType.AN_ERROR_HAS_OCCURRED.type;
    }
    if (e.response?.data is Map<String, dynamic>) {
      String error = e.response?.data['errorCode'] ?? e.message ?? 'Error';

      if (error.toString() == ErrorType.INPUT_INVALID.type || error.toString() == '203') {
        error = e.response?.data['errorDesc'];
      }
      return error.toString();
    }

    return e.message ?? ErrorType.AN_ERROR_HAS_OCCURRED.type;
  }
}

enum ErrorType {
  LOGIN_ERROR_01._("LOGIN_ERROR_01", "Email already exists", "이메일이 이미 존재합니다"),
  INPUT_EMPTY._("INPUT_EMPTY", "Input is empty", "입력이 비어있습니다"),
  SYSTEM_ERROR._("SYSTEM_ERROR", "System error", "시스템 오류"),
  VERIFY_ERROR._("VERIFY_ERROR", "Verify OTP error", "인증 오류"),
  PASSWORD_NOT_MATCH._("PASSWORD_NOT_MATCH", "Password not match", "비밀번호가 일치하지 않습니다"),
  OTP_EXPIRED._("OTP_EXPIRED", "OTP expired", "OTP 만료됨"),
  UNAUTHORIZED._('INVALID_TOKEN', 'Session expired', "세션 만료됨"),
  PASSWORD_OR_ACCOUNT_IN_ACTIVE._(
      'PASSWORD_OR_ACCOUNT_IN_ACTIVE', 'Incorrect password or account', "잘못된 비밀번호 또는 계정"),
  AN_ERROR_HAS_OCCURRED._('AN_ERROR_HAS_OCCURRED', 'An error has occurred', "오류가 발생했습니다"),
  INPUT_INVALID._('INPUT_INVALID', 'Input invalid', "입력 오류"),
  VERIFY_CONTACT_NOT_EXIST._('VERIFY_CONTACT_NOT_EXIST', 'Contact not exist', "연락처가 존재하지 않습니다"),
  THE_CONNECTION_ERRORED._('THE CONNECTION ERRORED', 'Server is under maintenance', "서버 점검중입니다"),
  THE_CONNECTION_TIMED_OUT._('TimeoutException', 'Time out', "시간 초과"),
  unknown._('UNKNOWN', 'Unknown Error', "알 수 없는 오류"),
  none._('NONE', 'The server is busy', "서버가 바빠요");

  const ErrorType._(
    this.type,
    this.nameEn,
    this.nameKo,
  );

  String getNameByLocale(String locale) {
    switch (locale) {
      case 'en':
        return nameEn;
      case 'ko':
        return nameKo;
      default:
        return nameKo;
    }
  }

  final String type;
  final String nameEn;
  final String nameKo;
}
