import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/utils/validators.dart';

class YaftaPasswordTextField extends StatefulWidget {
  YaftaPasswordTextField(
      {Key? key, this.editingController, this.label = "Contraseña"})
      : super(key: key);

  final TextEditingController? editingController;
  final String label;

  @override
  State<YaftaPasswordTextField> createState() => _YaftaPasswordTextFieldState();
}

class _YaftaPasswordTextFieldState extends State<YaftaPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return YaftaTextField(
      validator: requiredValidator,
      textController: widget.editingController,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      label: widget.label,
      obscureText: _obscureText,
    );
  }
}
