import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; //enable use of firebase_auth functions
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth
      .instance; //gives us an instance to the firebase AuthObject (funcitons) which is setup and managed by the firebasAuth package

  void _submitAuthForm(
    String email,
    String password,
    String uersName,
    bool isLoginMode,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      if (isLoginMode) {
        //if user has selected that he has an account
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ); //func available from FirebaseAuth
      } else {
        //if the user doesn't ahve an account
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on PlatformException catch (error) {
      //catch only errors thrown by the platform (firebase in our case)
      var message = 'An error occured, please check your credentials';
      if (error.message != null) {
        //if we get an message form the server
        message = error.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(//show the message error in a SnackBar (comes from the bottom)
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (error) {//to catch other type of errors
    print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
      ),
    );
  }
}
