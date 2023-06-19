import 'package:firebase_remote_config/firebase_remote_config.dart';

enum Config { appTheme, budgets, signInWithGoogle }

extension AppConfig on Config {
  String get name {
    switch (this) {
      case Config.appTheme:
        return "app_theme";
      case Config.budgets:
        return "budgets";
      case Config.signInWithGoogle:
        return "sign_in_with_google";
    }
  }
}

enum AppTheme {
  light,
  dark,
}

class RemoteConfigHandler {
  static final _remoteConfig = FirebaseRemoteConfig.instance;

  static void initializeDefaults() {
    _remoteConfig.setDefaults(<String, dynamic>{
      Config.appTheme.name: "light",
      Config.budgets.name: true,
      Config.signInWithGoogle.name: true,
    });
  }

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
}
