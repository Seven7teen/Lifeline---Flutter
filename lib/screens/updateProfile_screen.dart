import 'package:flutter/material.dart';
import 'package:lifeline/components/input_text.dart';
import 'package:lifeline/screens/home_screen.dart';
import 'package:lifeline/components/update_profile.dart';
import 'package:lifeline/components/round_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  static String id = 'updateProfile_screen';
  String userEmail;
  UpdateProfileScreen({@required this.userEmail});
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String username;
  String dob;
  String country;
  String password;
  final username_c = TextEditingController();
  final dob_c = TextEditingController();
  final password_c = TextEditingController();
  final country_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: Column(
            children: <Widget>[
              InputText(
                controller: username_c,
                ontap: (value) {
                  setState(() {
                    username = value;
                  });
                },
                hintText: 'Enter your username',
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline_outlined),
              ),
              InputText(
                controller: dob_c,
                ontap: (value) {
                  setState(() {
                    dob = value;
                  });
                },
                hintText: 'Enter your date of birth',
                labelText: 'Date of Birth',
                prefixIcon: Icon(Icons.calendar_today_outlined),
              ),
              InputText(
                controller: country_c,
                ontap: (value) {
                  setState(() {
                    country = value;
                  });
                },
                hintText: 'Enter your country',
                labelText: 'country',
                prefixIcon: Icon(Icons.location_city),
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                ontap: () async {
                  username_c.clear();
                  dob_c.clear();
                  country_c.clear();
                  if (username != null) {
                    UserData userdata = new UserData(
                      username: username,
                      dob: dob,
                      country: country,
                      userEmail: widget.userEmail,
                    );
                    await userdata.addToCloud();
                    Navigator.pop(context);
                  }
                },
                text: 'Add/Update',
                colour: Colors.blueGrey,
              ),
              SizedBox(
                height: 30,
              ),
              InputText(
                controller: password_c,
                ontap: (value) {
                  setState(() {
                    password = value;
                  });
                },
                hintText: 'Enter your new password',
                labelText: 'password',
                prefixIcon: Icon(Icons.vpn_key_outlined),
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                ontap: () async {
                  password_c.clear();
                  if (password != null) {
                    UserData userdata = new UserData();
                    await userdata.changePassword(password);
                    Navigator.pop(context);
                  }
                },
                text: ' Change password',
                colour: Colors.blueGrey,
              ),
            ],
          )),
    );
  }
}
