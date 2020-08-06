import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chats/new_message.dart';
import '../widgets/chats/messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging(); //used below to handle notifications
    fbm.requestNotificationPermissions(); //requiered only on ios
    fbm.configure(onMessage: (msg) {//wehn app is opened in use mode
      //configure - do something depending where you are when the notificaiton is received (app closed running in bacground, opened)
      print(msg);
      return;
    }, 
    onResume: (msg) {//when app is opened in bacground
      print(msg);
      return;
    }, 
    onLaunch: (msg) {
      print(msg);
      return;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: <Widget>[
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 20),
                        Text('LogOut'),
                      ],
                    ),
                  ),
                  value: 'logout' //this is just an identifier (itemIdentifier)
                  )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      )),
    );
  }
}
