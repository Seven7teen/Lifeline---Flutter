import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:lifeline/components/round_button.dart';
import 'package:lifeline/screens/welcome_screen.dart';
import 'package:lifeline/screens/home_screen.dart';
import 'package:lifeline/screens/login_screen.dart';
import 'package:lifeline/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Lifeline());
}

class Lifeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 44.0, horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: 400,
                margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 10.0),
                // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      image: AssetImage('assets/zero_screen.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 10.0),
                child: Column(
                  children: <Widget>[
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      pause: Duration(milliseconds: 5000),
                      animatedTexts: [
                        TyperAnimatedText(
                          'LIFELINE',
                          speed: Duration(milliseconds: 250),
                          textStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 80,
                              fontFamily: 'ChelaOne'),
                        ),
                      ],
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        'Stay in Touch',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80),
                child: LinearProgressIndicator(
                  value: controller.value,
                ),
              ),
              SizedBox(
                height: 120,
              ),
              controller.value == 1
                  ? RoundButton(
                      text: 'Lets get started',
                      ontap: controller.value == 1
                          ? () {
                              Navigator.pushNamed(context, WelcomeScreen.id);
                            }
                          : () {},
                      colour: controller.value == 1
                          ? Colors.lightBlueAccent
                          : Colors.white,
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
