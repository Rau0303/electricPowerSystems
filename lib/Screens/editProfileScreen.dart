import 'package:electric_power_systems/Widgets/buildTextField.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../Widgets/MyTextButton.dart';
import '../Widgets/myAppBar.dart';
class editProfileScreen extends StatefulWidget {
  const editProfileScreen({Key? key}) : super(key: key);

  @override
  State<editProfileScreen> createState() => _editProfileScreenState();
}

class _editProfileScreenState extends State<editProfileScreen> {

  final TextEditingController _fullNameController  = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar(myTitleText: const Text("Профиль"), arrow_back: true,)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){},
                    child: image==null ? const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 70,
                    )
                        :
                        CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 70,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextField(controller: _fullNameController, hintText: "Ваше имя", myIcon: null, obscure: false),
                  const SizedBox(height: 10,),
                  buildTextField(controller: _userEmailController, hintText: "Ваша почта", myIcon: null, obscure: false),
                  const SizedBox(height: 10,),
                  buildTextField(controller: _userPhoneController, hintText: "Ваш телефон", myIcon: null, obscure: false),

                  SizedBox(
                    width: double.infinity,
                    child: MyTextButton(
                      text: const Text("Сохранить"),
                      onPressed: (){},
                    )
                  )
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
