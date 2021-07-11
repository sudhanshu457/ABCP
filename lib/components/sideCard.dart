import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'bottom_sheet_text.dart';


class SideCard extends StatelessWidget {
  SideCard(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            color: Colors.deepPurple[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
