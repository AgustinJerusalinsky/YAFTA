import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/text_field.dart';

import '../../design_system/atoms/yafta_logo.dart';
import '../../design_system/molecules/button.dart';
import '../../design_system/molecules/password_text_field.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      final response =
          await context.read<AuthProvider>().login(email, password);
      //TODO: replace with logging framework
      context.go('/');
      // Navigate to home without context
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const YaftaLogo.imagotype(),
            YaftaTextField(label: "Email", textController: _emailController),
            YaftaPasswordTextField(
              editingController: _passwordController,
            ),
            YaftaButton(
                onPressed: _handleLogin,
                variant: "filled",
                secondary: true,
                text: "Login"),
            YaftaButton(
                variant: "text",
                text: "I don't have an account",
                onPressed: () => context.go("/signup"))
          ]),
        ));
  }
}
