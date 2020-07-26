import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;

  final bool isMe;

  MessageBubble(this.message, this.isMe);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).accentColor : Colors.purple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(15),

            ),
          ),
          width: screenWidth * 0.7,//as this will eventually be in a listView, we need to wrap the container in a row, otherwise the width will not work
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(message, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
