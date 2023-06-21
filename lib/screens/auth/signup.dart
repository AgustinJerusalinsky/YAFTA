import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/atoms/yafta_logo.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/routing/router_utils.dart';
import 'package:yafta/screens/auth/google_button.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:yafta/utils/analytics.dart';
import 'package:yafta/utils/remote_config.dart';

import '../../design_system/molecules/password_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  void _handleGoogleSignup() async {
    final response = await context.read<AuthProvider>().signInWithGoogle();
    AnalyticsHandler.logSignup();
    context.go(AppRoutes.home.path);
  }

  void _handleSignup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final passwordConfirmation = _passwordConfirmationController.text.trim();

    if (email.isNotEmpty &&
        password.isNotEmpty &&
        password == passwordConfirmation) {
      final response =
          await context.read<AuthProvider>().signup(email, password);
      AnalyticsHandler.logSignup();
      context.go(AppRoutes.home.path);

      // Navigate to home without context
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInWithGoogleEnabled = RemoteConfigHandler.getSignInWithGoogle();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
        child: Column(children: [
          const YaftaLogo.isologo(),
          const YaftaTextField(label: "Full name"),
          const YaftaTextField(label: "Username"),
          YaftaTextField(label: "Email", textController: _emailController),
          YaftaPasswordTextField(
            editingController: _passwordController,
          ),
          YaftaPasswordTextField(
            editingController: _passwordConfirmationController,
          ),
          YaftaButton(
              onPressed: _handleSignup,
              variant: "filled",
              secondary: true,
              text: "Sign up"),
          YaftaButton(
              variant: "text",
              text: "I already have an account",
              onPressed: () => context.go(AppRoutes.login.path)),
          if (signInWithGoogleEnabled) ...[
            const Divider(),
            GoogleButton(onPressed: _handleGoogleSignup)
          ]
        ]),
      ),
    );
  }
}
