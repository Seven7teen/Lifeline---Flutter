import 'package:flutter/material.dart';
import 'package:lifeline/components/input_text.dart';
import 'home_screen.dart';
import 'package:lifeline/components/update_profile.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          InputText(
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
            ontap: (value) {
              setState(() {
                password = value;
              });
            },
            hintText: 'Enter your new password',
            labelText: 'password',
            prefixIcon: Icon(Icons.vpn_key_outlined),
          ),
          InputText(
            ontap: (value) {
              setState(() {
                dob = value;
              });
            },
            hintText: 'Enter your date of birth',
            labelText: 'date of birth',
            prefixIcon: Icon(Icons.calendar_today_outlined),
          ),
          InputText(
            ontap: (value) {
              setState(() {
                country = value;
              });
            },
            hintText: 'Enter your country',
            labelText: 'country',
            prefixIcon: Icon(Icons.location_city),
          ),
          ElevatedButton(
            onPressed: () async {
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
            child: Text('Add/Update'),
          ),
          ElevatedButton(
            onPressed: () async {
              UserData userdata = new UserData();
              await userdata.changePassword(password);
            },
            child: Text(' change password'),
          ),
          ElevatedButton(
            onPressed: () async {
              UserData userdata = new UserData();
              await userdata.deleteAccount();
            },
            child: Text('Delete Account'),
          ),
        ],
      )),
    );
  }
}
