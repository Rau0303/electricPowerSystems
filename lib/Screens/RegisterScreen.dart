import 'package:country_picker/country_picker.dart';
import 'package:electric_power_systems/Screens/homeScreen.dart';
import 'package:electric_power_systems/Services/AuthService.dart';
import 'package:electric_power_systems/Widgets/buildTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/myButton.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userPhoneController = TextEditingController();

  Country country = Country(
      phoneCode: "+7",
      countryCode: "KZ",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Kazakhstan",
      example: "Kazakhstan",
      displayName: "Kazakhstan",
      displayNameNoCountryCode: "KZ",
      e164Key: "");

  void selectCountry(){
    showCountryPicker(
        context: context,
        onSelect: (value){
          setState(() {
            value = country;
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<authService>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    TextFormField(
                      controller: userPhoneController,
                      decoration: InputDecoration(
                        hintText: "Введите номер телефона",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Container(
                          margin: EdgeInsets.all(13.0),
                          child: InkWell(
                            onTap: (){
                              showCountryPicker(
                                  context: context,
                                  onSelect: (value){
                                    setState(() {
                                      country= value;
                                    });
                                  });
                            },
                            child: Text(
                              "${country.flagEmoji} ${country.phoneCode}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),

                        )

                      ),


                    ),

                    const SizedBox(height: 20,),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: MyButton(
                        text: 'Login',
                        //onPressed:()=> sendPhoneNumber(),
                        onPressed: (){
                          Navigator.push(
                              context,
                          MaterialPageRoute(builder: (context)=> homeScreen())
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  void sendPhoneNumber(){
    final ap = Provider.of<authService>(context,listen: false);
    String phoneNumber = country.phoneCode + userPhoneController.text.trim();
    ap.signInWithPhoneNumber(context, phoneNumber);
  }
}
