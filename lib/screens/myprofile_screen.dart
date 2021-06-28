import 'package:flutter/material.dart';
import 'package:lifeline/components/round_button.dart';
import 'updateProfile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyProfileScreen extends StatefulWidget {
  String userEmail;
  MyProfileScreen({@required this.userEmail});

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String email;
  String username;
  String dob, country;

  void initializeAllParams() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    await ref.doc('${widget.userEmail.toUpperCase()}').get().then((value) {
      setState(() {
        email = value['email'];
        username = value['username'];
        dob = value['dob'];
        country = value['country'];
      });
    });
    print(email);
    print(username);
    // print(userData);
  }

  @override
  void initState() {
    initializeAllParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyProfile'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(username == null ? 'null' : username),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(email == null ? 'null' : email),
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
            child: RoundButton(
              text: 'Update Profile',
              colour: Colors.grey,
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateProfileScreen(userEmail: widget.userEmail)));
                initializeAllParams();
              },
            ),
          ),
        ],
      ),
    );
  }
}
