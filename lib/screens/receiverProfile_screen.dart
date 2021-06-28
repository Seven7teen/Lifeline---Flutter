import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';

class ReceiverProfileScreen extends StatefulWidget {
  static String id = 'receiverProfile_screen';
  String receiverEmail;
  Icon icon;

  ReceiverProfileScreen({this.receiverEmail, this.icon});

  @override
  _ReceiverProfileScreenState createState() => _ReceiverProfileScreenState();
}

class _ReceiverProfileScreenState extends State<ReceiverProfileScreen> {
  String email, username;
  String dob, country;

  void initializeAllParams() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    await ref.doc('${widget.receiverEmail.toUpperCase()}').get().then((value) {
      setState(() {
        email = value['email'];
        username = value['username'];
        dob = value['dob'];
        country = value['country'];
        // userData = value['${widget.userEmail.toUpperCase()}'];
      });
    });
    print(email);
    print(username);
  }

  @override
  void initState() {
    initializeAllParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: widget.icon,
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(email == null ? 'null' : email),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(username == null ? 'null' : username),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(dob == null ? 'null' : dob),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(country == null ? 'null' : country),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.message),
              iconSize: 40.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      receiverEmail: email,
                      senderUserEmail: loggedInUser.email,
                      receiverUsername: username,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
