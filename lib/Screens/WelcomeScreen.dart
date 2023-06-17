import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electric_power_systems/Screens/RegisterScreen.dart';
import 'package:electric_power_systems/Screens/homeScreen.dart';
import 'package:electric_power_systems/Screens/signInScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/AuthService.dart';
import '../Widgets/myButton.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<authService>(context, listen: false);
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
                horizontal: MediaQuery.of(context).size.width*0.2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/car.png",
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

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: MyButton(
                      text: 'Lets start',
                      onPressed: () {
                        ap.isSignedIn==true
                            ?
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const homeScreen()))
                        :
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterScreen()));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const signInScreen()));

                      },
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
