import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/text_field.dart';

import '../../design_system/atoms/yafta_logo.dart';
import '../../design_system/molecules/button.dart';

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
        const YaftaTextField(label: "Password", obscureText: true),
        YaftaButton(
            onPressed: () => print("Login"),
            variant: "filled",
            secondary: true,
            child: const Text("Login")),
        YaftaButton(
            variant: "text",
            child: Text("I don't have an account"),
            onPressed: () => print("I don't have an account"))
      ]),
    ));
  }
}
