import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Helper{
 static Future<void> initializeFirebaseApp ()async{
    WidgetsFlutterBinding.ensureInitialized();
   try {
     await Firebase.initializeApp();
   } catch (e) {
     debugPrint('Error initializing Firebase: $e');
   }
}
}