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
      this.validator,
      this.onTap,
      this.readOnly = false,
      this.initialValue});
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
  final GestureTapCallback? onTap;
  final bool readOnly;
  final String? initialValue;

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
        readOnly: readOnly,
        onTap: onTap,
        initialValue: initialValue,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          hintText: hintText,
          errorText: errorText,
          floatingLabelStyle: readOnly ? TextStyle(color: Colors.grey) : null,
          focusedBorder: readOnly
              ? OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))
              : null,
          enabledBorder: readOnly
              ? OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))
              : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
