import 'package:flutter/material.dart';

import '../Widgets/myAppBar.dart';

class myFavoritesScreen extends StatefulWidget {
  const myFavoritesScreen({Key? key}) : super(key: key);

  @override
  State<myFavoritesScreen> createState() => _myFavoritesScreenState();
}

class _myFavoritesScreenState extends State<myFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar(myTitleText: const Text("Профиль"),arrow_back: false,)),
    );
  }
}
