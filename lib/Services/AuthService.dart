import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electric_power_systems/Models/userModel.dart';
import 'package:electric_power_systems/Screens/homeScreen.dart';
import 'package:electric_power_systems/Services/Snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/OtpScreen.dart';

class authService extends ChangeNotifier{
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading  => _isLoading;

  String? _uid ;
  String get uid => _uid!;

  userModel? _UserModel;
  userModel get UserModel => _UserModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  authService(){
    checkSignIn();
  }

  void checkSignIn() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin")?? false;
    notifyListeners();
  }

  Future setSignIn() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_signedin", true);
    _isLoading = true;
    notifyListeners();
  }


//user signIn
  void signInWithPhoneNumber(BuildContext context,String phoneNumber) async{
    try{
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async{
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException error){
            throw Exception(error.message);
          },
          codeSent: (=]
              , forceResendingToken){
            Navigator.push(
                context, 
              MaterialPageRoute(
                  builder: (context)=> otpScreen(verificationId: verificationId,),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId){}
      );
    }
        on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString(),true);
        }
  }
  //user verify

void veridyOtp({
  required BuildContext context,
  required String userOtp,
  required String verificationId,
  required Function onSuccess
})async{
  _isLoading =true;
  notifyListeners();
  try{
  PhoneAuthCredential creds = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOtp);
  User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;
  if(user != null){
    _uid = user.uid;
    onSuccess();
  }
  _isLoading = false;
  notifyListeners();
  } on FirebaseAuthException catch(e){
    showSnackBar(context, e.message.toString(),true);
    _isLoading = false;
    notifyListeners();
  }
}

// checking database

Future<bool> checkExistingUser() async{
    DocumentSnapshot snapshot = await _firebaseFirestore.collection("users").doc(_uid).get();

    if(snapshot.exists){
      print("user exists");
      return true;
    }
    else{
      print("new user");
      return false;
    }
}


//sign in with email and password;

void signInWithEmailAndPassword(BuildContext context, String email, String password)async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch(e){
      if(e.code =='user-not-found'){
        showSnackBar(context, 'Пользователь не существует', true);
        return;
      }
      else if(e.code == 'wrong-password'){
        showSnackBar(context, 'Неправильный пароль', true);
        return;
      }
      else{
        showSnackBar(context, 'Что то пошло не так!', true);
        print("wrong pass");
      }

    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)=> homeScreen(),
      ),
    );
}

// sign Up with email and password

void createUserWithEmailAndPassword(BuildContext context,String email,String password) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch(e){
      if(e.code == 'email-alreay-in-use'){
        showSnackBar(context, 'Такой Email уже используется, повторите попытку с использованием другого Email', true);
        return;
      }
      else{
        showSnackBar(context, 'Что - то пошло не так!', true);
        print("wrong pass");
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)=> homeScreen(),
      ),
    );
}

  void saveUserDataToFirebase(
  {
  required BuildContext context,
    required userModel UserModel,
    required File profilePicture,
    required Function onSuccess,
}) async{
    _isLoading = true;
    notifyListeners();
    try{
      // Загрузка фотографии на Firebase stroge
      await storeFileToStorage("profilePicture/$_uid", profilePicture).then((value){
        UserModel.profilePicture = value;
        UserModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        UserModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        UserModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _UserModel = UserModel;

      //загрузка в БД

      await _firebaseFirestore.collection("users").doc(_uid).set(UserModel.toMap()).then((value){
        onSuccess();
        _isLoading = false;
        notifyListeners();

      });

    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString(), true);
      _isLoading = false;
      notifyListeners();
    }

    
  }
  Future <String> storeFileToStorage(String ref, File file) async{
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Хранение данных локально

  Future saveUserDate() async{
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    await sharedPreferences.setString("userModel", jsonEncode(UserModel.toMap()));

  }
}