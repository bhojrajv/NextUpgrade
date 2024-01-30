# next_upgrade

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
## steps to configure google sign-in with firebase
1 should have account in firebase console 
2 create firebase project in console
3 configure your project with firebase according firebase instructions
4-copy and past dependecies and plugins in app/gradle and project/gradle
5 past google-service.json file inside app folder of project
6 add these necessary packages in your pubspec.yml file
get:
google_sign_in: ^5.2.1
firebase_auth: ^4.0.0
firebase_core: ^2.3.0
cloud_firestore:
7 I used Getx for statemanagement
8 cloud firestore to save data
