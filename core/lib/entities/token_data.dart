part of '../core.dart';

class TokenData {
  final String? accessToken;
  final String? tokenType;
  final String? refreshToken;
  final int? expiresIn;
  final List<String>? auth;
  final String? jti;
  final String? secretKey;

  const TokenData(
      {this.accessToken,
      this.tokenType,
      this.refreshToken,
      this.expiresIn,
      this.auth,
      this.jti,
      this.secretKey});

  factory TokenData.fromJson(Map<String, dynamic> json) {
    return TokenData(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'],
      auth: (json['auth'] as List?)?.map((e) => e as String).toList(),
      jti: json['jti'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'auth': auth,
      'jti': jti,
      'secretKey': secretKey,
    };
  }

  //copy with
  TokenData copyWith({
    String? accessToken,
    String? tokenType,
    String? refreshToken,
    int? expiresIn,
    List<String>? auth,
    String? jti,
    String? secretKey,
  }) {
    return TokenData(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      auth: auth ?? this.auth,
      jti: jti ?? this.jti,
      secretKey: secretKey ?? this.secretKey,
    );
  }
}
