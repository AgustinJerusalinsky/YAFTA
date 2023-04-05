import 'package:flutter/material.dart';

const smallSpacing = 10.0;

class YaftaTextField extends StatelessWidget {
  const YaftaTextField(
      {super.key,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.label,
      this.textController,
      this.errorText,
      this.hintText});
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String label;
  final String? hintText;
  final String? errorText;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallSpacing),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          hintText: hintText,
          errorText: errorText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
