import 'package:flutter/material.dart';

//reference: https://dartling.dev/displaying-a-loading-overlay-or-progress-hud-in-flutter
class YaftaOverlayLoading extends StatelessWidget {
  const YaftaOverlayLoading(
      {Key? key, required this.child, required this.isLoading})
      : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
