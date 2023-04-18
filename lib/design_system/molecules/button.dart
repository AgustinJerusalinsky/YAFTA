import 'package:flutter/material.dart';

class YaftaButton extends StatelessWidget {
  const YaftaButton(
      {Key? key,
      this.onPressed,
      required this.child,
      this.variant = 'filled',
      this.fullWidth = true,
      this.secondary = false})
      : super(key: key);
  final void Function()? onPressed;
  final Widget child;
  final String variant;
  final bool secondary;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 54,
        width: fullWidth ? double.infinity : null,
        child: _getButtonVariant(variant, onPressed, child, secondary));
  }

  Widget _getButtonVariant(variant, onPressed, child, secondary) {
    switch (variant) {
      case 'filled':
        if (secondary) {
          return FilledButton.tonal(onPressed: onPressed, child: child);
        }
        return FilledButton(onPressed: onPressed, child: child);
      case 'outlined':
        return OutlinedButton(onPressed: onPressed, child: child);
      case 'text':
        return TextButton(onPressed: onPressed, child: child);
      default:
        return FilledButton(onPressed: onPressed, child: child);
    }
  }
}
