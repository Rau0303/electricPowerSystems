import 'package:electric_power_systems/Services/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/AuthService.dart';
import '../Widgets/buildTextField.dart';
import '../Widgets/myButton.dart';
import 'homeScreen.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();
  final TextEditingController _userPassRepeatController = TextEditingController();




  @override
  void dispose() {
    _userNameController.dispose();
    _userPassController.dispose();
    _userPassRepeatController.dispose();
    super.dispose();
  }
  void signUp(){
    if(_userPassController.text!= _userPassRepeatController.text){
      showSnackBar(context, "пароли не совпадают!", true);
    }
    final ap = Provider.of<authService>(context,listen: false);
    ap.createUserWithEmailAndPassword(context, _userNameController.text.trim(), _userPassController.text.trim());
  }
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<authService>(context,listen: true);
    return Scaffold(
        body: Container(
          decoration:  const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(160, 102, 203, 1),
                Color.fromRGBO(134, 199, 237, 1),],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height*0.1,
                  horizontal: MediaQuery.of(context).size.width*0.1,
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
                    buildTextField(controller: _userNameController, hintText: "Email", myIcon: Icon(Icons.email), obscure: false),
                    const SizedBox(height: 10,),
                    buildTextField(controller: _userPassController, hintText: "Пароль", myIcon: Icon(Icons.password), obscure: true),
                    const SizedBox(height: 10,),
                    buildTextField(controller: _userPassRepeatController, hintText: "Повторите пароль ", myIcon: Icon(Icons.password), obscure: true),

                    const SizedBox(height: 20,),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: MyButton(
                        text: 'Login',
                        onPressed:()=> signUp(),
                        /*onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> homeScreen())
                          );
                        },*/
                      ),
                    )





                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
