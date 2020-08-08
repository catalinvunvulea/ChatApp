import 'package:ChatApp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness:
            Brightness.light, //to avoid having black text on purple
        buttonTheme: ButtonTheme.of(context).copyWith(
            //overwrite some of the default properties of a button
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(//enable us to show the screen depending on the status (user is login or not)
        stream: FirebaseAuth.instance.onAuthStateChanged,//receive firebase user data whenever user signIn or out (also store the token key in chache, it will check it if is still active etc)
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (userSnapshot.hasData) {//check if the data received hasData = the data is valid, then we will skip the login sceen
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
