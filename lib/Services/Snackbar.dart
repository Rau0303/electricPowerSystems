import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content,bool error){
     const errorColor = Colors.red;
     const okColor = Colors.green;

     Future<void> showSnackBar(BuildContext context, String message,bool error)async{
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: error? errorColor : okColor,
    );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}