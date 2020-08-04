//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus(); //to close the keyboard
    final user = await FirebaseAuth.instance.currentUser(); //gives acces to the user (including the user id)
    final userData = await Firestore.instance.collection('users').document(user.uid).get();//get the user id from users, so we can get the user name later
    Firestore.instance.collection('chat').add(
      {
        'text': _enteredMessage,
        'createdAt': Timestamp
            .now(), //made available by firestore cloud package; create it to sort the messages
        'userId': user.uid,
        'username': userData['username'],
        'userImage': userData['image_url'],
        
      }
    );
    _controller
        .clear(); //to clear the text from textField when this func is executed
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Send a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
