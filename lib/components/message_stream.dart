import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeline/components/message_bubble.dart';
import 'package:lifeline/screens/chat_screen.dart';

class MessagesStream extends StatelessWidget {
  @override
  MessagesStream({this.user});
  final user;

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: user.orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          print(loggedInUser.email);
          final messages = snapshot.data.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: loggedInUser.email == messageSender,
            );
            print(messageText);
            print(messageSender);
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              children: messageBubbles,
            ),
          );
        });
  }
}
