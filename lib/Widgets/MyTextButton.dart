import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
   MyTextButton({
    required this.text,
    required this.onPressed,
  });
  final Text text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: text );
  }
}