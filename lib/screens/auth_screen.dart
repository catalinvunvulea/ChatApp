import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; //enable use of firebase_auth functions
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; //store the image file

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth
      .instance; //gives us an instance to the firebase AuthObject (funcitons) which is setup and managed by the firebasAuth package

  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String uerName,
    File image,
    bool isLoginMode,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading =
            true; //to show a spinner while data is sent and received from firebase
      });
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
        //the following is done only when we have a new user
 
        final refX = FirebaseStorage.instance
            .ref() //ref takes us to the root bucket of the firebaseStorage (unlike firebase DataBase and Auth, instead of collections we have buckets, instead of documents we have paths )
            .child(
                'user_images') //child = where we want to store file of from where we read a file
            .child(authResult.user.uid +
                '.jpg'); //we create a sub-path(file) and name it as our user id (unique) and add the type (.jpg)  at the end
        await refX.putFile(
            image).onComplete; //put/add a file (image) at the above path on firebaseStorage, and use the last segment of the path (child with jpg)as the file name, takes longer, does not return a future hence we need to add onComplete to enable it as a future (and use await)

          final url = await refX.getDownloadURL();

        await Firestore.instance //accessing firestore
            .collection(
                'users') //accessing collection(folder) 'users' (or creating if it doesn't exist)
            .document(authResult.user
                .uid) //using the document from authResult (user.uid) to create the id (same as the one in auth)
            .setData({
          //add data in the folder accessed above
          'username': uerName,
          'email': email,
          'image_url': url,
        });
      }
    } on PlatformException catch (error) {
      //catch only errors thrown by the platform (firebase in our case)
      var message = 'An error occured, please check your credentials';
      if (error.message != null) {
        //if we get an message form the server
        message = error.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        //show the message error in a SnackBar (comes from the bottom)
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      //to catch other type of errors
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
