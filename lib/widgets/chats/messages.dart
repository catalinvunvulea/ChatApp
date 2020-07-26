import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //allow us to show different widgets on the screen depending on the stream (data from server which is accessed)
      stream: Firestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.documents;
        return ListView.builder(
          reverse: true, //put data at the bottom of the listView and not at the top
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => Text(chatDocs[index]['text']),
        );
      },
    );
  }
}
