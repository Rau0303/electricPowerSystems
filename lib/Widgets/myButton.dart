import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    required this.text,
    required this.onPressed
  });

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(decoration:BoxDecoration(gradient: LinearGradient(colors: [Color.fromRGBO(134, 199, 237, 1),Color.fromRGBO(24, 54, 178, 1)],

    ),
      borderRadius: BorderRadius.circular(30),
    ),

      child: TextButton(onPressed: onPressed,
        child:   Text( text,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),

      ),

    );
  }
}