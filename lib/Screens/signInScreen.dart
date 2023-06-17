import 'package:electric_power_systems/Screens/RegisterScreen.dart';
import 'package:electric_power_systems/Screens/SignUpScreen.dart';
import 'package:electric_power_systems/Services/Snackbar.dart';
import 'package:electric_power_systems/Widgets/MyTextButton.dart';
import 'package:electric_power_systems/Widgets/buildTextField.dart';
import 'package:electric_power_systems/Widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/AuthService.dart';
import 'homeScreen.dart';

class signInScreen extends StatefulWidget {
  const signInScreen({Key? key}) : super(key: key);

  @override
  State<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();




  @override
  void dispose() {
      _userNameController.dispose();
      _userPassController.dispose();
      super.dispose();
  }

  void login(){
    if(_userPassController.text.length<8){
      showSnackBar(context, "пароль должен быть больше 8 символов!", true);
      print("legth www");
    }
    else{
      final ap = Provider.of<authService>(context,listen: false);
      ap.signInWithEmailAndPassword(context, _userNameController.text.trim(), _userPassController.text.trim());
    }

  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<authService>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
          // Background
          decoration:  const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(160, 102, 203, 1),
                Color.fromRGBO(134, 199, 237, 1),],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height*0.01,
                horizontal: MediaQuery.of(context).size.width*0.03,
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/register.png",
                    height: MediaQuery.of(context).size.height*0.30,
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Давайте начнем",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),

                  ),
                  const SizedBox(height: 10,),

                  const Text(
                    "Никогда не было лучшего времени, чем сейчас, чтобы начать",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //userName
                  buildTextField(controller: _userNameController, hintText: "Email", myIcon: Icon(Icons.email), obscure: false),
                  const SizedBox(height: 10,),
                  //password
                  buildTextField(controller: _userPassController, hintText: "Пароль", myIcon: Icon(Icons.password), obscure: true),

                  const SizedBox(height: 20,),


                  //Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: MyButton(
                      text: 'Login',
                      onPressed:()=> login(),
                      /*onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> homeScreen())
                        );
                      },*/
                    ),
                  ),
                  SizedBox(height: 10,),

                  MyTextButton(text: const Text("Нет аккаунта? Зарегистрируйся!"), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const signUpScreen()));
                  }),
                  
                  SizedBox(
                    height: 15,
                  ),
                  Text("или"),
                  SizedBox(
                    height: 50,
                    child: IconButton(
                      icon: Icon(Icons.phone_android),
                      iconSize: 50,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterScreen()));
                      },
                    ),

                  )






                ],
              ),
            ),
          ),
        )
    );
  }
}
