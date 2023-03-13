import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class card_data extends StatefulWidget {
  // const card({super.key});
  String tn = "";
  String tv = "";
  card_data({required this.tn, required this.tv});
  @override
  State<card_data> createState() => _card_dataState();
}

class _card_dataState extends State<card_data> {
  /*
  String tn = "";
  String tv = "";
  void initState() {
    super.initState();
    tn = widget.tn;
    tv = widget.tv;
  }
  */
  // Text a = Text("HELLO");

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(widget.tn),
          TextFormField(
            initialValue: widget.tv,
            /*
            onChanged: (value) async {
              FirebaseFirestore.instance
                  .collection("user")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({widget.tn:value});
            },
            */
          )
        ],
      ),
    );
  }
}
