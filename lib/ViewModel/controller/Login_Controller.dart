import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:next_upgrade/Model/UserProfile.dart';


class LoginController extends GetxController{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isInit=false.obs.value;
  late final FirebaseApp app;
 late  FirebaseAuth  auth;
   bool isLogout=false.obs.value;
   bool isLogin=false.obs.value;
   UserProfile?userProfile;

   UserProfile get getProfile => userProfile??UserProfile();

   set setProfile(User users){
     userProfile=UserProfile(name:users.displayName,email: users.email,
      imageurl: users.photoURL,uid: users.uid);
     update();
   }
   //to handle google sign -in
  Future<User?> handleSignIn() async {
    try {
         if(app!=null){
           auth=FirebaseAuth.instanceFor(app: app);
         }else{
           debugPrint("app:${app}");
         }
       isLogout=true;
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await auth.signInWithCredential(credential);
      final User? user = authResult.user;
         setProfile=user!;
         isLogout=false;
         isLogin=true;
      debugPrint("Signed in: ${user!.displayName}");
      debugPrint("Signed in: ${user!.photoURL}");
      debugPrint("Signed in: ${user!.email}");
      debugPrint("uid2: ${user!.uid}");
      update();
      return user;
    } catch (error) {
      isLogout=false;
      isLogin=false;
      update();
      debugPrint("Error signing in with Google: $error");
      return null;
    }
  }
  //to check current user sign-in
  String isUser=''.obs.value;
  String isCurrentUser(){
    isUser=auth.currentUser?.uid??'';
     debugPrint("useruid:$isUser");
     update();
     return isUser;
  }
  // to Get user profilel
  void getUserprofile(){
    setProfile=FirebaseAuth.instance.currentUser!;
    update();
  }
  // to sign out from google login
  Future<void> signOut() async {
    await auth.signOut();
    await _googleSignIn.signOut();
    isLogout=true;
    debugPrint("logout;$isLogout");
    update();
  }
  // to initialize firebase app
  Future<void> initializeFirebaseApp ()async{
    WidgetsFlutterBinding.ensureInitialized();

    try {
     app= await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: "AIzaSyBtYw1vpcH68mmQ27IlzwNlkUr2pksKV6g",
          appId: "1:610783308423:android:bc8116da2f7d80a1fe6622",
          messagingSenderId: "610783308423",
          projectId: "nextupgrade-4518e")
      );
     auth=FirebaseAuth.instanceFor(app: app);
      isInit=true;
      update();
    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
    }
  }
}