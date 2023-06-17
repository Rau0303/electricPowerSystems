import 'package:electric_power_systems/Models/userModel.dart';
import 'package:electric_power_systems/Screens/homeScreen.dart';
import 'package:electric_power_systems/Services/AuthService.dart';
import 'package:electric_power_systems/Services/Snackbar.dart';
import 'package:electric_power_systems/Widgets/buildTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  // select image

  void selectImage() async{
    image = await pickImage(context);
    setState(() {

    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _userEmailController.dispose();
    _userPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<authService>(context,listen: true).isLoading;
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
                    onTap: ()=> selectImage(),
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
                      onPressed: ()=> storeData(),
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

  void storeData() async{
    final ap = Provider.of<authService>(context,listen: false);
    userModel UserModel = userModel(
        name: _fullNameController.text.trim(),
        email: _userEmailController.text.trim(),
        profilePicture: "",
        phoneNumber: _userPhoneController.text.trim(),
        uid: "",
      createdAt: "",

    );
    if(image != null){
      ap.saveUserDataToFirebase(
          context: context,
          UserModel: UserModel,
          profilePicture: image!,
          onSuccess: (){
            ap.saveUserDate().then((value) =>ap.setSignIn().then((value)=>
            Navigator.pop(context)));
          });
    }
  }
}
