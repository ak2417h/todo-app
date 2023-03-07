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
  final db = FirebaseFirestore.instance
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser!.uid);
  // final db = FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser!.uid);
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: db.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("ERROR")));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              Map<String, dynamic> a = snapshot.data.data();
              List<dynamic> al = a.values
                  .where((element) => element != snapshot.data.data()!["name"])
                  .toList();
              try {
                return Column(
                  children: al.map((e) {
                    return Card(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Task 1" + snapshot.data.data()!["Task 1"],
                        ),
                        onChanged: (value) {
                          FirebaseFirestore.instance
                              .collection("user")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({"Task 1": value});
                        },
                      ),
                    );
                  }).toList(),
                );
              } catch (e) {
                return CircularProgressIndicator();
              }
            }
            return CircularProgressIndicator();
          },
        ),
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
