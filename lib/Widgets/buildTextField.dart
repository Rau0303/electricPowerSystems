import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class buildTextField extends StatelessWidget {
  buildTextField({
    required this.controller,
    required this.hintText,
    required this.myIcon,
    required this.obscure
  });

  final TextEditingController controller;
  final String hintText;
  final Icon? myIcon;
  final bool obscure;


  @override
  Widget build(BuildContext context) {
    return TextField(

      controller: controller,
      obscureText: obscure,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          suffixIcon: myIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
      ),

    );
  }
}