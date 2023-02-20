import 'package:flutter/material.dart';

class MyBackground extends StatelessWidget {
  const MyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration:  const BoxDecoration(

            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(160, 102, 203, 1),
                Color.fromRGBO(134, 199, 237, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
  }
}