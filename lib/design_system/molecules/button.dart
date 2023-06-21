import 'package:flutter/material.dart';

class YaftaButton extends StatelessWidget {
  const YaftaButton(
      {Key? key,
      this.onPressed,
      required this.text,
      this.variant = 'filled',
      this.color,
      this.fullWidth = true,
      this.child,
      this.secondary = false,
      this.textStyle})
      : super(key: key);
  final void Function()? onPressed;
  final Widget? child;
  final String variant;
  final String text;
  final bool secondary;
  final bool fullWidth;
  final Color? color;
  final TextStyle? textStyle;

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
    switch (variant) {
      case 'filled':
        if (secondary) {
          return FilledButton.tonal(
              onPressed: onPressed,
              child: Text(
                text,
                style: theme!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer),
              ));
        }
        return FilledButton(
          onPressed: onPressed,
          style: color != null
              ? ButtonStyle(backgroundColor: MaterialStatePropertyAll(color))
              : null,
          child: Text(
            text,
            style: textStyle,
          ),
        );
      case 'outlined':
        return OutlinedButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: textStyle,
            ));
      case 'text':
        return TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: textStyle,
            ));
      default:
        return FilledButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: textStyle,
            ));
    }
  }
}
