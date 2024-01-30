
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_upgrade/View/Home_Screen.dart';
import 'package:next_upgrade/ViewModel/controller/Login_Controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginController _loginController=Get.put(LoginController());
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2),()=>checkUser());
    super.initState();
  }

  void checkUser(){
    _loginController.isCurrentUser()!=""
        ?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()))
        :LoginScreen();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Center(
        child:ElevatedButton(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text("Sign-In With Google"),
            Image.asset("assets/google.jpg",fit: BoxFit.cover,width: 30,height: 30,)],),
          onPressed: ()async{
            await _loginController.handleSignIn();
            if(_loginController.isLogin==true){
              Get.to(()=>HomeScreen());
            }

          }, ) ,
      ),
      ),
    );
  }
}
