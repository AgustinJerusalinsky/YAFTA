import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/design_system/molecules/yafta_overlay_loading.dart';
import 'package:yafta/routing/router_utils.dart';
import 'package:yafta/screens/auth/google_button.dart';
import 'package:yafta/utils/errors.dart';
import 'package:yafta/utils/validators.dart';

import '../../design_system/atoms/yafta_logo.dart';
import '../../design_system/molecules/button.dart';
import '../../design_system/molecules/password_text_field.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_provider.dart';
import '../../utils/remote_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;
  String _errorMessage = "";

  void _handleGoogleSignup() async {
    try {
      setState(() {
        _submitting = true;
      });
      await context.read<AuthProvider>().signInWithGoogle();
      context.go(AppRoutes.home.path);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _submitting = false;
        _errorMessage = getAuthErrorMessage(e.code);
      });
    }
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submitting = true;
      });
      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        await context.read<AuthProvider>().login(email, password);
        context.go(AppRoutes.home.path);
      } on FirebaseAuthException catch (e) {
        setState(() {
          _submitting = false;
          _errorMessage = getAuthErrorMessage(e.code);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInWithGoogleEnabled = RemoteConfigHandler.getSignInWithGoogle();

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: YaftaLogo.imagotype(),
                  ),
                  YaftaTextField(
                    label: "Email",
                    textController: _emailController,
                    validator: emailValidator,
                  ),
                  YaftaPasswordTextField(
                    editingController: _passwordController,
                  ),
                  YaftaButton(
                      variant: 'text',
                      text: "Olvidé mi contraseña",
                      onPressed: () =>
                          context.go(AppRoutes.forgotPassword.path)),
                  const SizedBox(height: 32),
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
                      onPressed: _handleLogin,
                      variant: "filled",
                      secondary: true,
                      text: "Iniciar sesión"),
                  YaftaButton(
                      variant: "text",
                      text: "Crear una cuenta",
                      onPressed: () => context.go(AppRoutes.signup.path)),
                  if (signInWithGoogleEnabled) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(),
                    ),
                    GoogleButton(onPressed: _handleGoogleSignup)
                  ]
                ]),
              ),
            )));
  }
}
