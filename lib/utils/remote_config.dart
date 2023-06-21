import 'package:firebase_remote_config/firebase_remote_config.dart';

enum Config { appTheme, budgets, signInWithGoogle, appThemeToggle }

extension AppConfig on Config {
  String get name {
    switch (this) {
      case Config.appTheme:
        return "app_theme";
      case Config.budgets:
        return "budgets";
      case Config.signInWithGoogle:
        return "sign_in_with_google";
      case Config.appThemeToggle:
        return "app_theme_toggle";
    }
  }
}

enum AppTheme {
  light,
  dark,
}

extension AppThemeExtension on AppTheme {
  String get name {
    switch (this) {
      case AppTheme.light:
        return "light";
      case AppTheme.dark:
        return "dark";
    }
  }
}

const String noCategoryName = "No category";

class RemoteConfigHandler {
  static final _remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> _setDefaults() async =>
      _remoteConfig.setDefaults(<String, dynamic>{
        Config.appTheme.name: "dark",
        Config.budgets.name: true,
        Config.signInWithGoogle.name: false,
        Config.appThemeToggle.name: true,
      });

  static Future<void> initialize() async {
    await _setConfigSettings();
    await _setDefaults();
    await _fetchAndActivate();
  }

  static Future<void> _fetchAndActivate() async =>
      _remoteConfig.fetchAndActivate();

  static Future<void> _setConfigSettings() async =>
      _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 1),
      ));

  static AppTheme getTheme() {
    final theme = _remoteConfig.getString(Config.appTheme.name);
    if (theme == "light") {
      return AppTheme.light;
    } else {
      return AppTheme.dark;
    }
  }

  static bool getBudgets() {
    return _remoteConfig.getBool(Config.budgets.name);
  }

  static bool getSignInWithGoogle() {
    return _remoteConfig.getBool(Config.signInWithGoogle.name);
  }

  static bool getAppThemeToggle() {
    return _remoteConfig.getBool(Config.appThemeToggle.name);
  }
}
