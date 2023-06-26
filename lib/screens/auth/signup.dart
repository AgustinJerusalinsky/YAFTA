import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/atoms/yafta_logo.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/design_system/molecules/yafta_overlay_loading.dart';
import 'package:yafta/routing/router_utils.dart';
import 'package:yafta/screens/auth/google_button.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:yafta/utils/analytics.dart';
import 'package:yafta/utils/errors.dart';
import 'package:yafta/utils/remote_config.dart';
import 'package:yafta/utils/validators.dart';

import '../../design_system/molecules/password_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;
  String _errorMessage = "";

  void _handleGoogleSignup() async {
    try {
      setState(() {
        _submitting = true;
      });
      await context.read<AuthProvider>().signInWithGoogle();
      //If platform is android send analytics event
      if (Theme.of(context).platform == TargetPlatform.android) {
        AnalyticsHandler.logSignup();
      }
      context.go(AppRoutes.home.path);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _submitting = false;
        _errorMessage = getAuthErrorMessage(e.code);
      });
    }
  }

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      final password = _passwordController.text.trim();
      final passwordConfirmation = _passwordConfirmationController.text.trim();
      if (password != passwordConfirmation) {
        setState(() {
          _errorMessage = "Las contraseñas no coinciden";
        });
        return;
      }
      setState(() {
        _submitting = true;
      });
      try {
        final email = _emailController.text.trim();
        final fullName = _fullNameController.text.trim();
        final username = _usernameController.text.trim();

        await context
            .read<AuthProvider>()
            .signup(email, password, fullName, username);
        if (Theme.of(context).platform == TargetPlatform.android) {
          AnalyticsHandler.logSignup();
        }
        context.go(AppRoutes.home.path);
      } on FirebaseException catch (e) {
        setState(() {
          _submitting = false;
          _errorMessage = getAuthErrorMessage(e.code);
        });
      }

      // Navigate to home without context
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInWithGoogleEnabled =
        RemoteConfigHandler.instance!.getSignInWithGoogle();
    return SafeArea(
      child: Scaffold(
        body: YaftaOverlayLoading(
          isLoading: _submitting,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
            child: Form(
              onChanged: () {
                setState(() {
                  _errorMessage = "";
                });
              },
              key: _formKey,
              child: ListView(children: [
                const YaftaLogo.isologo(),
                YaftaTextField(
                  label: "Nombre completo",
                  textController: _fullNameController,
                  validator: requiredValidator,
                ),
                YaftaTextField(
                  label: "Nombre de usuario",
                  textController: _usernameController,
                  validator: requiredValidator,
                ),
                YaftaTextField(
                  label: "Email",
                  textController: _emailController,
                  validator: emailValidator,
                ),
                YaftaPasswordTextField(
                  editingController: _passwordController,
                ),
                YaftaPasswordTextField(
                  editingController: _passwordConfirmationController,
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                YaftaButton(
                    onPressed: _handleSignup,
                    variant: "filled",
                    secondary: true,
                    text: "Registrarse"),
                YaftaButton(
                    variant: "text",
                    text: "Ya tengo una cuenta",
                    onPressed: () => context.go(AppRoutes.login.path)),
                if (signInWithGoogleEnabled) ...[
                  const Divider(),
                  GoogleButton(onPressed: _handleGoogleSignup)
                ]
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
