import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'bottom_sheet_text.dart';
import 'package:geocoder/geocoder.dart';

class NotificationCard extends StatelessWidget {
  NotificationCard(
      { this.infection,
        this.contactUsername,
      });


  final String infection;
  final String contactUsername;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        trailing: Icon(Icons.more_horiz),
        title: Text(
          contactUsername,
          style: TextStyle(
            color: Colors.deepPurple[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: infection =='Infected' ?Text("User is Infected! Please Do the Covid test"):Text("User is not infected!"),
      ),
    );
  }
}
