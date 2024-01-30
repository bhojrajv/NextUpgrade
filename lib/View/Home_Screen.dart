
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_upgrade/Model/TaskModel.dart';
import 'package:next_upgrade/View/Login.dart';
import 'package:next_upgrade/View/TaskList.dart';
import 'package:next_upgrade/View/Task_Screen.dart';
import 'package:next_upgrade/ViewModel/controller/Login_Controller.dart';
import 'package:next_upgrade/ViewModel/controller/Theme_Controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginController _loginController=Get.put(LoginController());
  ThemeController _themeController=Get.put(ThemeController());
  @override
  void initState() {
    // TODO: implement initState
    _loginController.getUserprofile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(_loginController.getProfile.name??""),
                accountEmail: Text(_loginController.getProfile.email??""),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(_loginController.getProfile.imageurl??""),
                ),
              ),
            ],
          ),
        ),
      appBar: AppBar(title: Text("Home"),actions: [Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: InkWell(onTap:()async{
          await _loginController.signOut();
          if(_loginController.isLogout==true){
            Navigator.pushReplacement(context, MaterialPageRoute(builder:
                (context)=>LoginScreen()));
          }else{
            debugPrint("islogout:${_loginController.isLogout}");
          }
        },child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(onTap: (){
              _themeController.toggleTheme();
            },
                child: Icon(Icons.lightbulb,size: 25,)),
            SizedBox(width: 12,),
            Icon(Icons.logout,size: 25,),
          ],
        )),
      )],),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('userTasks')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("No Task Description found yet"));
          }

          List<TaskModel> tasks = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return TaskModel(
              uid: doc.id,
              description: data['description'],
              isComplete: data['isComplete'],
            );
          }).toList();

          return TaskList(tasks: tasks,userid: _loginController.getProfile.uid,);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskScreen()),
      );
    },
    child: Icon(Icons.add),
    ),
    );
  }
}
