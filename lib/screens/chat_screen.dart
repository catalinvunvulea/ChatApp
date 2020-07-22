import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (ctx, index) => Container(
            padding: EdgeInsets.all(8),
            child: Text('This works'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Firestore.instance
                .collection('chats/HR6jgiJzeeditrjJc8uf/messages')//get acces to that path from firestore; this snapshot returns a stream which can be listened to whenever there is a change
                .snapshots()
                .listen(
                    (data) {
                      data.documents.forEach((document) { 
                        print(document['text']);
                      });
                      
                    }); 
          },
        ));
  }
}
