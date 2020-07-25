import 'package:flutter/material.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';

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
        accentColorBrightness: Brightness.light, //to avoid having black text on purple
        buttonTheme: ButtonTheme.of(context).copyWith( //overwrite some of the default properties of a button
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))

        ),
      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen()
    );
  }
}


