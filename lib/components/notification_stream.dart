import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/notificationCard.dart';

bool infectedStatus;
Firestore _firestore = Firestore.instance;

class NotificationStream extends StatelessWidget {
  final loggedInUserEmail;
  static int notificationCount = 0;

  NotificationStream(this.loggedInUserEmail);

  // NotificationStream(loggedUserEmail) {
  //   this.loggedInUserEmail = loggedUserEmail;
  // }

  Future<String> getInfectedStatus(id) async {
    bool isInf;

    return await Firestore.instance
        .collection('users')
        .document(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data}');
        isInf = documentSnapshot.data['is infected'];
        return (documentSnapshot.data['is infected'] ? 'Infected' : 'Not Infected');
      } else {
        return 'No data available';
      }
    });
  }

  Future<String> getStringInf(String id) async {
    return await getInfectedStatus(id);
  }

  static bool isNoNotification() {
    return (notificationCount == 0);
  }

  @override
  Widget build(BuildContext context) {
    notificationCount = 0;
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .document(loggedInUserEmail)
          .collection('met_with')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<NotificationCard> messageBubbles = [];
        for (var message in messages) {
          final users = message.data['username'];

          Firestore.instance.collection('users')
              .where('username', isEqualTo: users)
              .snapshots()
              .listen((QuerySnapshot querySnapshot){
            querySnapshot.documents.forEach((document) {
              infectedStatus = document.data['is infected'];
              //print(infectedStatus);
            });
          }
          );
          String xyz;
          print(infectedStatus);
          if(infectedStatus==null)
            xyz="No data available";
          else
            xyz = infectedStatus ? 'Infected' : 'Not Infected';
          if(xyz == null)
            xyz = 'No data available';

          int counter = 0;

          if(xyz == 'Infected') {
            notificationCount++;
            final messageBubble = NotificationCard(
              infection: xyz,
              contactUsername: users,
            );
            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
