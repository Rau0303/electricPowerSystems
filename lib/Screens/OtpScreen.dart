import 'package:electric_power_systems/Screens/homeScreen.dart';
import 'package:electric_power_systems/Services/AuthService.dart';
import 'package:electric_power_systems/Services/Snackbar.dart';
import 'package:electric_power_systems/Widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
class otpScreen extends StatefulWidget {
  final String verificationId;

  otpScreen({required this.verificationId});

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  TextEditingController otpControler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<authService>(context,listen: true).isLoading;
    String otpCode;
    return Scaffold(
      body: isLoading ==true
        ? const Center(
        child: CircularProgressIndicator(
          color: Colors.purple,
        ),
      )
     : Container(
        decoration: const BoxDecoration(
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
                  horizontal: MediaQuery.of(context).size.width*0.01,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: ()=> Navigator.of(context).pop(),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    Image.asset(
                      "assets/login.png",
                      height: MediaQuery.of(context).size.height*0.30,
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      "Верификация",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),

                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      "Вам было отправлено код верификации ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Pinput(
                      controller: otpControler,
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white30,
                          )

                        ),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )

                      ),

                    ),
                    const SizedBox(height: 15,),
                    SizedBox(
                     height: 50,
                      width: double.infinity,
                      child: MyButton(text: "verify",
                        onPressed:()=> verifyOtp(context, otpControler.text.trim()),

                      ),
                    ),




                  ],
                ),
              ),
            ),
          ),
      ),
      
    );

  }
  void verifyOtp(BuildContext context,String userOtp){
    final ap = Provider.of<authService>(context,listen: false);
    ap.veridyOtp(
        context: context,
        userOtp: userOtp,
        verificationId: widget.verificationId,
        onSuccess: (){
          ap.checkExistingUser().then((value) async {
            if(value==true){
              // user existing

            }else{
              // new user
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => const homeScreen())
                  , (route) => false);
            }
          });
        });

  }

}
