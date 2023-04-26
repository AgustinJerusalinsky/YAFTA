import 'package:flutter/material.dart';

class YaftaButton extends StatelessWidget {
  const YaftaButton(
      {Key? key,
      this.onPressed,
      required this.text,
      this.variant = 'filled',
      this.fullWidth = true,
      this.child,
      this.secondary = false})
      : super(key: key);
  final void Function()? onPressed;
  final Widget? child;
  final String variant;
  final String text;
  final bool secondary;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 54,
        width: fullWidth ? double.infinity : null,
        child:
            _getButtonVariant(context, variant, onPressed, child, secondary));
  }

  Widget _getButtonVariant(context, variant, onPressed, child, secondary) {
    final theme = Theme.of(context).textTheme.labelLarge;
    print(theme);
    switch (variant) {
      case 'filled':
        if (secondary) {
          return FilledButton.tonal(
              onPressed: onPressed,
              child: Text(
                text,
                style: theme,
              ));
        }
        return FilledButton(onPressed: onPressed, child: Text(text));
      case 'outlined':
        return OutlinedButton(onPressed: onPressed, child: Text(text));
      case 'text':
        return TextButton(onPressed: onPressed, child: Text(text));
      default:
        return FilledButton(onPressed: onPressed, child: Text(text));
    }
  }
}
