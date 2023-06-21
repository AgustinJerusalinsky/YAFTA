import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/button.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, required this.onPressed}) : super(key: key);
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return YaftaButton(
        text: "Continuar con Google",
        variant: "outlined",
        onPressed: onPressed);
  }
}
