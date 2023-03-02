import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  int s = 1;
  String task = "";
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () async {
          return showDialog(
            useRootNavigator: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("TEST"),
                actions: [
                  TextField(
                    onChanged: (value) => task = value,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      labelText: "Task Name",
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (task == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Enter A Task")));
                      } else {
                        await FirebaseFirestore.instance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .set({"Task $s": task}, SetOptions(merge: true));
                        s++;
                        Navigator.pop(context);
                      }
                      task = "";
                    },
                    child: Text("Submit"),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
