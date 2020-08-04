import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key
      key; //added becaus of the way flutter rebuild the widgets; it would work withouth it, but it is safer this way

  MessageBubble(this.message, this.userName, this.userImage, this.isMe,
      {this.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
              width: screenWidth *
                  0.7, //as this will eventually be in a listView, we need to wrap the container in a row, otherwise the width will not work
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isMe ? 'Me' : userName,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
   
          ],
        ),
         Positioned(
          top: 0 ,
          left: isMe ? null : screenWidth * 0.65,
          right: isMe ? screenWidth * 0.65 : null,
          child: CircleAvatar(backgroundImage: NetworkImage(userImage),),
        ),
      ],
      overflow: Overflow.visible,//withouth this, the image won't show (if positined is negative)
    );
  }
}
