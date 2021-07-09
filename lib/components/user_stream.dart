import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeline/screens/home_screen.dart';
import 'package:lifeline/screens/chat_screen.dart';
import 'package:lifeline/screens/receiverProfile_screen.dart';

class UserStream extends StatefulWidget {
  UserStream({
    @required this.user,
    @required this.widget,
  });

  final CollectionReference user;
  final HomeScreen widget;

  @override
  _UserStreamState createState() => _UserStreamState();
}

class _UserStreamState extends State<UserStream> {
  String last_seen = '-----';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.user.orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final users = snapshot.data.docs.reversed;
          List<Card> usersList = [];
          for (var user in users) {
            final userName = user.data()['username'];
            final receiverEmail = user.data()['email'];
            final userid = user.data()['userID'];
            if (userid != widget.widget.userID) {
              final listElement = Card(
                elevation: 5.0,
                // margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: InkWell(
                  // splashColor: Colors.red,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          receiverEmail: receiverEmail,
                          receiverUsername: userName,
                          senderUserEmail: widget.widget.userEmail,
                          receiverUserId: userid,
                          senderUserId: widget.widget.userID,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.auto_awesome,
                      color: Colors.pink,
                      size: 25,
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.person_sharp,
                        color: Colors.black,
                        size: 25,
                      ),
                      onTap: () {
                        // print(receiverEmail);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReceiverProfileScreen(
                                receiverEmail: receiverEmail,
                                icon: Icon(Icons.person_pin)),
                          ),
                        );
                      },
                    ),
                    title: Text(
                      userName,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    subtitle: Text(
                      last_seen,
                    ),
                    minVerticalPadding: 10.0,
                  ),
                ),
              );
              usersList.add(listElement);
              // final SpacelistElement = ListTile(),
            }
          }
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            children: usersList,
          );
        });
  }
}
