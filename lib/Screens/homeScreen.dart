import 'package:electric_power_systems/Screens/favoritesScreen.dart';
import 'package:electric_power_systems/Screens/profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'MyMapScreen.dart';



class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int currentIndex = 0;
   List<Widget> tabs = [
     Mymap(),
     myFavoritesScreen(),
     Center(child: Text("cars"),),
     profileScreen(),
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar:  Container(
        color: Colors.black,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02,vertical: MediaQuery.of(context).size.height*0.02),
          child: GNav(
            onTabChange: (index){
              setState(() {
                currentIndex = index;
              });
            },
            gap: 10,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              padding: EdgeInsets.all(10),


              tabs:const [
                GButton(icon: Icons.location_on,
                text: "Карта",),
                GButton(icon: Icons.favorite_border,
                text: "Избранное",),
                GButton(icon: Icons.flash_on,
                text: "Зарядка",),
                GButton(icon: Icons.account_circle_outlined,
                text: "Профиль",),
              ]
          ),
        ),
      ),

    );
  }
}




