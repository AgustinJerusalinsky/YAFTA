// Card with title, main section and footer. all optional

import 'package:flutter/material.dart';

class YaftaCard extends StatelessWidget {
  const YaftaCard({
    Key? key,
    this.title,
    this.mainSection,
    this.footer,
    this.color,
    this.borderColor,
  }) : super(key: key);

  final Widget? title;
  final Widget? mainSection;
  final Widget? footer;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: borderColor ?? Theme.of(context).colorScheme.surfaceVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) title!,
          if (title != null) const SizedBox(height: 20),
          if (mainSection != null)
            Padding(padding: const EdgeInsets.all(16.0), child: mainSection!),
          if (footer != null) const SizedBox(height: 20),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
