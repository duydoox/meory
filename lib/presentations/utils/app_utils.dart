import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:core/locales/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:meory/presentations/routes.dart';
import 'package:mime/mime.dart';

class AppUtils {
  static const int validScore = 5000;

  static AppLocalizations? get tr {
    final context = AppNavigator.context;
    return AppLocalizations.of(context);
  }

  static String buildBase64WithHeader(String base64Str) {
    if (base64Str.startsWith('data:')) return base64Str;
    try {
      Uint8List bytes = base64Decode(base64Str);
      String? mimeType = lookupMimeType('', headerBytes: bytes);
      mimeType ??= 'application/octet-stream';
      return 'data:$mimeType;base64,$base64Str';
    } catch (e) {
      debugPrint('Lỗi khi decode base64: $e');
      return base64Str;
    }
  }

  static String fileToBase64(File file) {
    try {
      Uint8List bytes = file.readAsBytesSync();
      String? mimeType = lookupMimeType('', headerBytes: bytes);
      mimeType ??= 'application/octet-stream';
      String dataBase64 = base64Encode(file.readAsBytesSync());
      return 'data:$mimeType;base64,$dataBase64';
    } catch (e) {
      debugPrint('Error reading file: $e');
      return '';
    }
  }
}
