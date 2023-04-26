import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/text_field.dart';

import '../../design_system/atoms/yafta_logo.dart';
import '../../design_system/molecules/button.dart';
import '../../design_system/molecules/password_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const YaftaLogo.imagotype(),
        const YaftaTextField(label: "Username"),
        YaftaPasswordTextField(),
        YaftaButton(
            onPressed: () => print("Login"),
            variant: "filled",
            secondary: true,
            text: "Login"),
        YaftaButton(
            variant: "text",
            text: "I don't have an account",
            onPressed: () => print("I don't have an account"))
      ]),
    ));
  }
}
