import 'package:flutter/material.dart';

class MyLabel extends StatelessWidget {
  const MyLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height*0.01,
      child: Container(
        height: MediaQuery.of(context).size.height*0.35,
        width: MediaQuery.of(context).size.width*0.80,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white,
            width: 3,

          ),
        ),
        child: Column(
          children: const [
            Icon(Icons.car_crash,size: 150,color: Colors.white,),

            Text(
              "ELECTRIC",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 36,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              "POWER SYSTEM",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),);
  }
}