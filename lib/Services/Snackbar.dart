import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

Future<File?> pickImage(BuildContext context)async{
  File? image;
  try{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      image =  File(pickedImage.path);
    }
  }catch(e){
    showSnackBar(context, e.toString(), true);
  }
  return image;
}
