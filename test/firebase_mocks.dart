import 'package:yafta/utils/remote_config.dart';

class FakeRemoteConfigHandler implements RemoteConfigHandler {
  @override
  bool getAppThemeToggle() {
    return true;
  }

  @override
  bool getBudgets() {
    return true;
  }

  @override
  bool getSignInWithGoogle() {
    return true;
  }

  @override
  AppTheme getTheme() {
    return AppTheme.light;
  }
}
