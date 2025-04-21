import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'error_handler.dart';

class BaseRepository extends AppBaseRepo {
  @override
  List<String> get whiteAuthList => [];

  @override
  Future<String> get accessToken async {
    final tokenData = await AppSecureStorage.getToken();
    return tokenData?.accessToken ?? '';
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map && response.data['errorCode'] != null) {
      return handler.reject(DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      ));
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException e, ErrorInterceptorHandler handler) async {
    if ((e.response?.statusCode == 401 || e.response?.statusCode == 403)) {
      bool isSuccess = await refreshToken();

      if (isSuccess) {
        return handler.resolve(await dio.fetch(e.requestOptions));
      }
    }

    final isBlocked = ErrorHandler().loadError(e);

    final dioException = e.copyWith(
      message: ErrorHandler().handleError(e),
    );

    if (isBlocked) {
      return handler.reject(dioException);
    }

    super.onError(dioException, handler);
  }

  Future<bool> refreshToken() async {
    bool isSuccess = false;
    final tokenData = await AppSecureStorage.getToken();

    if (tokenData == null || tokenData.refreshToken == null) {
      return isSuccess;
    }

    final result = await Result.guardAsync(
      () => post(
        "<put your refresh api endpoint here>",
        {
          "refreshToken": tokenData.refreshToken,
        },
      ),
    );

    result.ifSuccess((data) async {
      // TODO: Save new token
      isSuccess = true;
    });

    result.ifError((error, errorData) async {
      // TODO: Put your error handling here

      isSuccess = false;
    });

    return isSuccess;
  }

  @protected
  String catchError(Object e) {
    if (e is DioException) {
      return e.message ?? '';
    }
    return kDebugMode ? e.toString() : ErrorType.AN_ERROR_HAS_OCCURRED.type;
  }
}
