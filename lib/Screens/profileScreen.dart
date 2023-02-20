import 'dart:io';

import 'package:electric_power_systems/Screens/editProfileScreen.dart';
import 'package:flutter/material.dart';

import '../Widgets/myAppBar.dart';
import '../Widgets/myBoxDecoration.dart';
import '../Widgets/myListTile.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar(myTitleText: const Text("Профиль"),arrow_back: false,)),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
        child: Container(
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){},
                    child: image == null? const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 70,
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 60,
                        color: Colors.white,
                      ),
                    ): CircleAvatar(
                      backgroundImage: FileImage(image!),
                      radius: 50,
                    ),

                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    child: Flexible(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                          decoration: myBoxDecoration(),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Статистика"),//TextButton or ListTile
                                Card(
                                  child: myListTile(
                                    leading: const Icon(Icons.flash_on,color: Colors.green,),
                                    title: "Зарядка",
                                    trailing: const Text("0.0kv/h"),
                                    onTap: (){
                                      print("object");
                                    },
                                  ),
                                ),

                                Card(
                                  child: myListTile(
                                    leading: const Icon(Icons.wallet,color: Colors.green,),
                                    title: "Стоимость зарядки",
                                    trailing: Text("0.0T"),
                                    onTap: (){
                                      print("object");
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SingleChildScrollView(
                    child: Flexible(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: myBoxDecoration(),
                          child:Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Статистика"),//TextButton or ListTile
                                  Card(
                                    child: myListTile(
                                      leading: Icon(Icons.account_circle_outlined,color: Colors.green,),
                                      title: "Настройки профиля",
                                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const editProfileScreen()));
                                      },
                                    ),
                                  ),
                                  Card(
                                    child: myListTile(
                                      leading: Icon(Icons.wallet,color: Colors.green,),
                                      title: "Способ оплаты",
                                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                                      onTap: (){},
                                    ),
                                  ),
                                  Card(
                                    child: myListTile(
                                      leading: Icon(Icons.key,color: Colors.green,),
                                      title: "Изменить пароль",
                                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                                      onTap: (){},
                                    ),
                                  ),
                                  Card(
                                    child: myListTile(
                                      leading: Icon(Icons.exit_to_app,color: Colors.green,),
                                      title: "Выход",
                                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                                      onTap: (){},
                                    ),
                                  ),
                                  Card(
                                    child: myListTile(
                                      leading: Icon(Icons.restore_from_trash_outlined,color: Colors.green,),
                                      title: "Удалить аккаунт",
                                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                                      onTap: (){},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
        ),
        ),
      )
    );
  }


}




