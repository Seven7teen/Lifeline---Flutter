import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeline/components/user_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeline/screens/welcome_screen.dart';
import 'myprofile_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  String userEmail;
  String userID;
  HomeScreen({@required this.userID, @required this.userEmail});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Chats'),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.person,
                  ),
                  iconSize: 30,
                  onPressed: () {
                    print(widget.userEmail);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyProfileScreen(
                          userEmail: widget.userEmail,
                        ),
                      ),
                    );
                  },
                ),
                // SizedBox(width: 5.0),
                IconButton(
                  icon: Icon(
                    Icons.power_settings_new_outlined,
                  ),
                  iconSize: 30,
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Do you want to Sign Out?'),
                      content: const Text('Stay in Touch...'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.popUntil(
                                context, ModalRoute.withName(WelcomeScreen.id));
                          },
                          child: const Text('Sign Out'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('No'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: UserStream(user: user, widget: widget),
    );
  }
}
