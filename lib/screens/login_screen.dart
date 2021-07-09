import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/round_button.dart';
import 'package:lifeline/screens/home_screen.dart';
import 'package:lifeline/screens/registration_screen.dart';
import 'package:lifeline/screens/welcome_screen.dart';
import 'package:lifeline/components/input_text.dart';

User loggedInUser;

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String userID;
  final email_c = TextEditingController();
  final pass_c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('assets/Applook.PNG'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InputText(
                controller: email_c,
                ontap: (value) {
                  email = value;
                },
                hintText: 'Enter your email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              InputText(
                controller: pass_c,
                ontap: (value) {
                  password = value;
                },
                hintText: 'Enter your password',
                labelText: 'password',
                prefixIcon: Icon(Icons.vpn_key_outlined),
              ),
              SizedBox(
                height: 30,
              ),
              RoundButton(
                  text: 'LOGIN',
                  ontap: () async {
                    email_c.clear();
                    pass_c.clear();
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        loggedInUser = _auth.currentUser;
                        userID = loggedInUser.uid;
                        print(loggedInUser.email);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              userEmail: loggedInUser.email,
                              userID: userID,
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Incorrect email or password'),
                          // content: const Text('Stay in Touch...'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                      print(e);
                    }
                  },
                  colour: Colors.lightBlueAccent),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Dont have an account?',
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
                            RegistrationScreen.id,
                            ModalRoute.withName(WelcomeScreen.id));
                      },
                      child: Text(
                        'Register',
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
      ),
    );
  }
}
