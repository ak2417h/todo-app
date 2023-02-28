// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  @override
  String a = "";

  final db = FirebaseFirestore.instance
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser!.uid);

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

  Widget build(BuildContext context) {
    func();
    return FutureBuilder(
      future: db.get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "Welcome " + snapshot.data.data()!["name"] + "!",
              style: TextStyle(
                fontSize: 35,
              ),
            ),
          );
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
    // return Container(
    //   alignment: Alignment.center,
    //   child: Text(
    //     "Welcome " + a,
    //     style: TextStyle(
    //       fontSize: 35,
    //     ),
    //   ),
    // );
  }
}
