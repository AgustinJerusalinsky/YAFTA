import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const smallSpacing = 10.0;

class YaftaTextField extends StatelessWidget {
  const YaftaTextField(
      {super.key,
      this.prefixIcon,
      this.suffixIcon,
      required this.label,
      this.obscureText = false,
      this.textController,
      this.errorText,
      this.hintText,
      this.keyboardType = TextInputType.text,
      this.inputFormatters,
      this.validator});
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final bool obscureText;
  final String? hintText;
  final String? errorText;
  final TextEditingController? textController;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallSpacing),
      child: TextFormField(
        controller: textController,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) => validator!(value!),
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
