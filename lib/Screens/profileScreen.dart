import 'package:electric_power_systems/Screens/editProfileScreen.dart';
import 'package:electric_power_systems/Screens/energyHistory.dart';
import 'package:electric_power_systems/Screens/walletScreen.dart';
import 'package:electric_power_systems/Widgets/buildTextField.dart';
import 'package:electric_power_systems/Widgets/myBoxDecoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Widgets/buildAccountOption.dart';
import '../Widgets/myAppBar.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController newConPassController = TextEditingController();

  String? name = null;

  void onTap(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>energyHistory()));
  }

  Future<void> changePass() async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Изменить пароль"),
            content: SingleChildScrollView(
              child: ListBody(

                children: [
                  buildTextField(controller: currentPassController, hintText: "Введите старый пароль", myIcon: Icon(CupertinoIcons.eye), obscure: true),
                  const SizedBox(height: 10,),
                  buildTextField(controller: newPassController, hintText: "Введите новый пароль", myIcon: Icon(CupertinoIcons.eye), obscure: true),
                  const SizedBox(height: 10,),
                  buildTextField(controller: newConPassController, hintText: "Повторите новый пароль", myIcon: Icon(CupertinoIcons.eye), obscure: true),
                ],
              ),
            ),
            actions: [
              CupertinoDialogAction(child: TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("Сохранить")),),

            ],
          );

        });

  }

  Future<void> exitAccount() async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Вы действительное хотите выйти из профиля?",
            textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: null,
            actions: [

              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Нет")),
              SizedBox(width: 150,),

              TextButton(onPressed: (){}, child: Text("Да")),
            ],
          );
        });
  }

  Future<void> removeAccount() async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Вы действительное хотите удалить аккаунт?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            content: const Text(
                "Вы не сможете просматривать историю своих зарядок и бронировать зарядные станции"
            ,textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,

              ),
            ),
            actions: [

              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Нет")),
              SizedBox(width: 150,),

              TextButton(onPressed: (){}, child: Text("Да")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: myAppBar(myTitleText: const Text("Профиль"),arrow_back: false,)),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: name == null
                            ?
                        const Text(
                          "Ваше имя",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),)
                            :
                             Text("$name",
                             style: const TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.black),),
                             ),

                      const SizedBox(
                        height: 15,
                      ),
                      //Баланс
                      SingleChildScrollView(
                        child: Flexible(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: myBoxDecoration(),
                              child:Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Баланс"),//TextButton or ListTile


                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      //Статистика
                      SingleChildScrollView(
                        child: Flexible(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: myBoxDecoration(),
                              child:Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Статистика",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.black45
                                      ),),//TextButton or ListTile

                                      buildAccountOption(title: "Энергия", onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const energyHistory()));
                                      }
                                      ),
                                      Divider(height: 10,thickness: 2,),
                                      buildAccountOption(title: "Стоимость зарядки", onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const energyHistory()));
                                      }),

                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      //Профиль
                      SingleChildScrollView(
                        child: Flexible(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: myBoxDecoration(),
                              child:Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Профиль",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.black45
                                      ),),//TextButton or ListTile
                                      buildAccountOption(title: "Настройки профиля", onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const editProfileScreen()));
                                      }),
                                      Divider(height:10 ,thickness: 2,),
                                      buildAccountOption(title: "Способы оплаты", onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const walletScreen()));
                                      }),
                                      Divider(height:10 ,thickness: 2,),
                                      buildAccountOption(title: "Изменить пароль", onTap: (){
                                        changePass();
                                      }),
                                      Divider(height:10 ,thickness: 2,),
                                      buildAccountOption(title: "Выход", onTap: (){
                                        exitAccount();
                                      }),
                                      Divider(height:10 ,thickness: 2,),
                                      buildAccountOption(title: "Удалить аккаунт", onTap: (){
                                        removeAccount();
                                      }),



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
          ],
        ),
    );
  }


}










