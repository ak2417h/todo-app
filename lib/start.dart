// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class startClass extends StatefulWidget {
  const startClass({super.key});

  @override
  State<startClass> createState() => _startClassState();
}

class _startClassState extends State<startClass> {
  @override
  String a = "";

  final db = FirebaseFirestore.instance
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  /*
  Future<void> func() async {
    try {
      final db = FirebaseFirestore.instance;
      await db
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) {
        setState(() {
          a = value.data()!["name"];
        });
      });
    } catch (e) {}
  }
  */

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          try {
            var name = snapshot.data.data()!["name"];
            return Container(
              decoration: BoxDecoration(color: Colors.indigo[300]),
              alignment: Alignment.center,
              child: Text(
                "Welcome " + snapshot.data.data()!["name"] + "!",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            );
          } catch (e) {
            if (e.toString() ==
                "type 'Null' is not a subtype of type 'String'") {
              // no name
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              );
            } else if (e.toString() ==
                "Null check operator used on a null value") {
              // name doesn't exist
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              );
            }
            return Container(
              alignment: Alignment.center,
              child: Text(
                e.toString(),
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            );
          }
        }
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error")));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
