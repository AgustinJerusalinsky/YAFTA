import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:yafta/screens/auth/signup.dart';

import 'login.dart';

class AuthLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      if (state.uri.pathSegments.contains('login'))
        const BeamPage(
          key: ValueKey('login'),
          child: LoginScreen(),
        ),
      if (state.uri.pathSegments.contains('signup'))
        const BeamPage(
          key: ValueKey('signup'),
          child: SignupScreen(),
        ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/auth'];
}
