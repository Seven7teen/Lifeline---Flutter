import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/components/message_stream.dart';
import 'package:lifeline/screens/welcome_screen.dart';

User loggedInUser;

class ChatScreen extends StatefulWidget {
  String receiverUsername;
  String senderUserEmail;
  String receiverEmail;
  String receiverUserId;
  String senderUserId;

  ChatScreen(
      {this.receiverUsername,
      this.receiverUserId,
      this.senderUserId,
      this.senderUserEmail,
      this.receiverEmail});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String messageText;
  final messageTextController = TextEditingController();

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final receiver = FirebaseFirestore.instance.collection(
        'users/${widget.senderUserEmail.toUpperCase()}/${widget.receiverEmail.toUpperCase()}');
    final sender = FirebaseFirestore.instance.collection(
        'users/${widget.receiverEmail.toUpperCase()}/${widget.senderUserEmail.toUpperCase()}');
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat: Hey ${widget.receiverUsername.toUpperCase()}'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(
              user: receiver,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      receiver.add({
                        'sender': widget.senderUserEmail,
                        'text': messageText,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      sender.add({
                        'sender': widget.senderUserEmail,
                        'text': messageText,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
