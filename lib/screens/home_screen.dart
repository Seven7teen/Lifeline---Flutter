import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeline/components/user_stream.dart';
import 'package:lifeline/components/round_button.dart';
import 'myprofile_screen.dart';
import 'package:lifeline/screens/login_screen.dart';

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
      body: Container(
        margin: EdgeInsets.all(30.0),
        padding: EdgeInsets.all(20.0),
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundButton(
              text: 'Profile',
              colour: Colors.grey,
              ontap: () {
                print(widget.userEmail);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyProfileScreen(userEmail: widget.userEmail)));
              },
            ),
            RoundButton(
              text: 'log out',
              colour: Colors.black,
              ontap: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(LoginScreen.id));
              },
            ),
            Container(
              child: ElevatedButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('AlertDialog Title'),
                    content: const Text('AlertDialog description'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
            Container(
              color: Colors.white,
              child: UserStream(user: user, widget: widget),
            ),
          ],
        ),
      ),
    );
  }
}
