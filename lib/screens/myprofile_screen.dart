import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/round_button.dart';
import 'updateProfile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeline/components/update_profile.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('My Profile'),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.refresh_outlined,
                  ),
                  iconSize: 30,
                  onPressed: () {
                    initializeAllParams();
                  },
                ),
                // SizedBox(width: 5.0),
                IconButton(
                  icon: Icon(
                    Icons.warning_sharp,
                  ),
                  iconSize: 30,
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Do you want to delete your account?'),
                      content: const Text('Stay in Touch...'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            UserData userdata = new UserData();
                            await userdata.deleteAccount();
                          },
                          child: Text('Delete Account'),
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        width: 600,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profile_bc.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: Colors.pink[50],
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  username == null ? 'null' : 'Username: ${username}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              color: Colors.pink[50],
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  email == null ? 'null' : 'Email: ${email}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              color: Colors.pink[50],
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  dob == null ? 'null' : 'Date of Birth: ${dob}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              color: Colors.pink[50],
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  country == null ? 'null' : 'Nationalism: ${country}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: RoundButton(
                text: 'Update Profile',
                colour: Colors.blueGrey,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateProfileScreen(userEmail: widget.userEmail),
                    ),
                  );
                  initializeAllParams();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
