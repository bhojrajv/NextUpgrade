
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_upgrade/View/Login.dart';
import 'package:next_upgrade/ViewModel/controller/Login_Controller.dart';
import 'package:next_upgrade/ViewModel/controller/Theme_Controller.dart';
LoginController _loginController=Get.put(LoginController());
void main() async{
 await _loginController.initializeFirebaseApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(
        (){
          final isDarkMode = Get.put(ThemeController());
         return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: '',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),

            darkTheme: ThemeData.dark(),
            themeMode: isDarkMode.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/',
            routes: {
              '/':(context)=>LoginScreen()
            },
          );
        }
    );
  }
}


