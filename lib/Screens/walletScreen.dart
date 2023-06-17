import 'package:electric_power_systems/Widgets/myButton.dart';
import 'package:flutter/material.dart';

import '../Widgets/myAppBar.dart';

class walletScreen extends StatefulWidget {
  const walletScreen({Key? key}) : super(key: key);

  @override
  State<walletScreen> createState() => _walletScreenState();
}

class _walletScreenState extends State<walletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar(myTitleText: const Text("Способы оплаты"), arrow_back: true,)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Text(
                  "Для оплаты зарядки или бронирования станций необходимо привязать банковскую карту",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
                ),
                  ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: MyButton(
                  text: "Привязать карту",
                  onPressed: (){},
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
