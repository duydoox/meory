import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class MainAppSecureStorageKeys {
  MainAppSecureStorageKeys._();

  static const String profile = 'profile';
  static const String isLocalAuthEnabled = 'isLocalAuthEnabled';
  static const String localAuthEnabledFor = 'localAuthEnabledFor';
  static const String isSecurityRole = "isSecurityRole";
  static const String isCleaningRole = "isCleaningRole";
}

class MainAppSecureStorage {
  // static Future<void> setProfile(UserProfile? value) async {
  //   final storage = getIt.get<FlutterSecureStorage>();
  //   final rawProfile = jsonEncode(value?.toJson());
  //   await storage.delete(key: MainAppSecureStorageKeys.profile);
  //   await storage.write(key: MainAppSecureStorageKeys.profile, value: rawProfile);
  // }

  // static Future<UserProfile?> getProfile() async {
  //   final storage = getIt.get<FlutterSecureStorage>();
  //   final rawProfile = await storage.read(key: MainAppSecureStorageKeys.profile);

  //   if (rawProfile == null) {
  //     return null;
  //   }

  //   final Map<String, dynamic>? profileData = jsonDecode(rawProfile);

  //   if (profileData == null || profileData.isEmpty == true) {
  //     return null;
  //   }

  //   return UserProfile.fromJson(profileData);
  // }

  static Future setBiometricAuthenticate(bool biometricAuthenticate) async {
    final storage = getIt.get<FlutterSecureStorage>();

    await storage.write(
        key: MainAppSecureStorageKeys.isLocalAuthEnabled,
        value: biometricAuthenticate.toString());
  }

  static Future<bool> getBiometricAuthenticate() async {
    final storage = getIt.get<FlutterSecureStorage>();
    final rawBiometricAuthenticate =
        await storage.read(key: MainAppSecureStorageKeys.isLocalAuthEnabled);

    if (rawBiometricAuthenticate == null) {
      return false;
    }

    return rawBiometricAuthenticate == 'true';
  }

  static Future setLocalAuthEnabledFor(String localAuthEnabledFor) async {
    final storage = getIt.get<FlutterSecureStorage>();

    await storage.write(key: localAuthEnabledFor, value: localAuthEnabledFor);
  }

  static Future<String?> getLocalAuthEnabledFor() async {
    final storage = getIt.get<FlutterSecureStorage>();
    final rawLocalAuthEnabledFor =
        await storage.read(key: MainAppSecureStorageKeys.localAuthEnabledFor);

    return rawLocalAuthEnabledFor;
  }

  static Future setSecurityRole(bool value) async {
    final storage = getIt.get<FlutterSecureStorage>();
    await storage.write(
        key: MainAppSecureStorageKeys.isSecurityRole,
        value: json.encode(value));
  }

  static Future<bool> getSecurityRole() async {
    final storage = getIt.get<FlutterSecureStorage>();
    final value =
        await storage.read(key: MainAppSecureStorageKeys.isSecurityRole);
    if (value != null) {
      return jsonDecode(value);
    }
    return false;
  }

  static Future setCleaningRole(bool value) async {
    final storage = getIt.get<FlutterSecureStorage>();
    await storage.write(
        key: MainAppSecureStorageKeys.isCleaningRole,
        value: json.encode(value));
  }

  static Future<bool> getCleaningRole() async {
    final storage = getIt.get<FlutterSecureStorage>();
    final value =
        await storage.read(key: MainAppSecureStorageKeys.isCleaningRole);
    if (value != null) {
      return jsonDecode(value);
    }
    return false;
  }
}
