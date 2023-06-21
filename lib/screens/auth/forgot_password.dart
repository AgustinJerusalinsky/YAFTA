import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/design_system/molecules/yafta_overlay_loading.dart';
import 'package:yafta/routing/router_utils.dart';
import 'package:yafta/utils/errors.dart';
import 'package:yafta/utils/validators.dart';

import '../../design_system/atoms/yafta_logo.dart';
import '../../design_system/molecules/button.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;
  bool _success = false;
  String _errorMessage = "";

  void _handleForgotPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submitting = true;
      });
      try {
        final email = _emailController.text.trim();

        // await context.read<AuthProvider>().login(email, password);
        setState(() {
          _submitting = false;
          _success = true;
        });
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
                  if (_success) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: YaftaLogo.imagotype(),
                    ),
                    YaftaTextField(
                      label: "Email",
                      textController: _emailController,
                      validator: emailValidator,
                    ),
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
                        onPressed: _handleForgotPassword,
                        variant: "filled",
                        secondary: true,
                        text: "Recuperar contraseña"),
                  ] else ...[
                    Text(
                        "Se envió un email a ${_emailController.text.trim()} con las instrucciones para recuperar tu contraseña.}")
                  ],
                  YaftaButton(
                      variant: "text",
                      text: "Volver",
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.arrow_back_ios), Text("Volver")],
                      ),
                      onPressed: () => context.go(AppRoutes.login.path)),
                ]),
              ),
            )));
  }
}
