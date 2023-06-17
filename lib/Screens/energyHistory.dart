import 'package:flutter/material.dart';

import '../Widgets/myAppBar.dart';
class energyHistory extends StatefulWidget {
  const energyHistory({Key? key}) : super(key: key);

  @override
  State<energyHistory> createState() => _energyHistoryState();
}

class _energyHistoryState extends State<energyHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar(myTitleText: const Text("История зарядок"),arrow_back: true,)),

    );
  }
}



