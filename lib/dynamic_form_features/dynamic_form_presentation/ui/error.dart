import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        '404 screen',
        style: TextStyle(color: Colors.red, fontSize: 20),
      ),
    ));
  }
}
