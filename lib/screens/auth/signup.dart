import 'package:flutter/material.dart';
import 'package:yafta/design_system/atoms/yafta_logo.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
        child: Column(children: [
          const YaftaLogo.isologo(),
          const YaftaTextField(label: "Full name"),
          const YaftaTextField(label: "Username"),
          const YaftaTextField(label: "Email"),
          const YaftaTextField(label: "Password", obscureText: true),
          const YaftaTextField(label: "Confirm password", obscureText: true),
          YaftaButton(
              onPressed: () => print("Sign up"),
              variant: "filled",
              secondary: true,
              child: const Text("Sign up")),
          YaftaButton(
              variant: "text",
              child: const Text("I already have an account"),
              onPressed: () => print("I already have an account"))
        ]),
      ),
    );
  }
}
