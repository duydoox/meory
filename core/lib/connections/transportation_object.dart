part of '../core.dart';

@immutable
class TransportationObject {
  final String accessToken;
  final AppTheme theme;

  const TransportationObject({
    required this.accessToken,
    required this.theme,
  });
}
