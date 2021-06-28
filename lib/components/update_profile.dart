import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String username;
  String userEmail;
  String dob, country;

  UserData({this.username, this.userEmail, this.dob, this.country});

  Future addToCloud() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('users');

    // var userName;
    // await ref.doc('${userEmail.toUpperCase()}').get().then((value) {
    //   userName = value['username'];
    //
    // });

    // if (userName != username) {
    await ref.doc('${userEmail.toUpperCase()}').update({
      'username': username,
      'dob': dob,
      'country': country,
    });
  }

  Future deleteAccount() async {
    User user = await FirebaseAuth.instance.currentUser;
    user.delete();
  }

  Future changePassword(String password) async {
    User user = await FirebaseAuth.instance.currentUser;
    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
    // }
  }
}
