import 'package:flutter/material.dart';
import 'package:lifeline/screens/login_screen.dart';
import 'package:lifeline/screens/registration_screen.dart';
import 'package:lifeline/components/round_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('assets/Applook.PNG'),
                      height: 60.0,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Text(
                  'LIFELINE',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundButton(
              text: 'LOGIN',
              colour: Colors.lightBlue,
              ontap: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundButton(
              text: 'REGISTER',
              colour: Colors.green,
              ontap: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
