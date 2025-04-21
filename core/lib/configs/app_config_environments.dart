part of '../core.dart';

class EnvironmentConfig {
  static void setEnvironment(String value) {
    AppSP.set(AppSP.environment, value);
  }

  static String? getEnvironment() {
    return AppSP.get(AppSP.environment);
  }
}

class Environments {
  static const String production = 'PROD';
  static const String qa = 'QA';
  static const String dev = 'DEV';
  static final String _currentEnvironments = EnvironmentConfig.getEnvironment() ?? qa;
  static final List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.dev,
      'url': 'http://14.225.11.29:2306/mcrs-api',
    },
    {
      'env': Environments.qa,
      'url': 'http://14.225.11.29:2306/mcrs-api',
    },
    {
      'env': Environments.production,
      'url': 'http://14.225.11.29:2306/mcrs-api',
    },
  ];

  static String getUrl() {
    return _availableEnvironments.firstWhere(
          (d) => d['env'] == _currentEnvironments,
        )['url'] ??
        '';
  }

  static String getEnvironment() {
    return _availableEnvironments.firstWhere(
          (d) => d['env'] == _currentEnvironments,
        )['env'] ??
        Environments.dev;
  }
}
