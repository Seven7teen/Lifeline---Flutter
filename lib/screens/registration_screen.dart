import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/input_text.dart';
import 'package:lifeline/components/round_button.dart';
import 'package:lifeline/screens/login_screen.dart';
import 'package:lifeline/screens/home_screen.dart';

User loggedInUser;

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String username;
  String userID;
  String dob;
  String country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(20.0, 100, 20.0, 20.0),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'chat_icon',
                child: Icon(
                  Icons.chat,
                  color: Colors.red,
                  size: 200.0,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InputText(
              ontap: (value) {
                username = value;
              },
              hintText: 'Enter your username',
              labelText: 'Username',
              prefixIcon: Icon(Icons.person_outline_outlined),
            ),
            InputText(
              ontap: (value) {
                email = value;
              },
              hintText: 'Enter your email',
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            InputText(
              ontap: (value) {
                password = value;
              },
              hintText: 'Enter your password',
              labelText: 'password',
              prefixIcon: Icon(Icons.vpn_key_outlined),
            ),
            InputText(
                ontap: (value) {
                  dob = value;
                },
                hintText: 'Enter your date of birth',
                labelText: 'Date of Birth',
                prefixIcon: Icon(Icons.calendar_today_outlined)),
            InputText(
                ontap: (value) {
                  country = value;
                },
                hintText: 'Enter your country',
                labelText: 'country',
                prefixIcon: Icon(Icons.location_city)),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                text: 'REGISTER',
                ontap: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (newUser != null) {
                      loggedInUser = _auth.currentUser;
                      userID = loggedInUser.uid;
                      print(loggedInUser.email);
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc('${email.toUpperCase()}')
                          .set({
                        // 'userData': userData,
                        //     {
                        'username': username,
                        'email': email,
                        'timestamp': FieldValue.serverTimestamp(),
                        'userID': loggedInUser.uid,
                        'dob': dob,
                        'country': country,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                    userEmail: loggedInUser.email,
                                    userID: userID,
                                  )));
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                colour: Colors.green),
            SizedBox(
              height: 150,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.id,
                          ModalRoute.withName(RegistrationScreen.id));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
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
