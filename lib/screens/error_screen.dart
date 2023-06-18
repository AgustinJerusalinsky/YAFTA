import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, this.statusCode = 500, this.errorMessage = ""})
      : super(key: key);
  final int statusCode;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Error $statusCode: $errorMessage"),
    );
  }
}
