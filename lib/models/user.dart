import 'package:yafta/utils/remote_config.dart';

class User {
  final String uid;
  final String? email;
  final String? fullName;
  final String? userName;
  final AppTheme theme;

  User({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.userName,
    this.theme = AppTheme.light,
  });
}
