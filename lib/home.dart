import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Map<String, dynamic>? _map = new Map();
  Widget build(BuildContext context) {
    String task = "";

    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // List<String> alist;
            //     if (snapshot.data.data().legnth == 1) {
            //       List<String> alist = [];
            //     } else {
            //       List<String> alist = snapshot.data.data()["info"].keys;
            //       alist.sort((a, b) {
            //         return a.compareTo(b);
            //       });
            //     }
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("ERROR")));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              try {
                return Scaffold(
                  body: Center(
                    child: Column(
                      // children: snapshot.data.data()["info"].values.map((e) {
                      //   Text(e);
                      // }).toList(),
                      children: [Text("HI")],
                    ),
                  ),
                  /*
                  body: Container(
                    alignment: Alignment.center,
                    width: 350,
                    child: Expanded(
                      child: Text(
                        snapshot.data.data().toString(),
                      ),
                    ),
                  ),
                  */
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton.extended(
                    backgroundColor: Colors.deepPurple[300],
                    label: Text("New Task"),
                    icon: Icon(
                      Icons.add,
                      size: 40,
                    ),
                    onPressed: () async {
                      return showDialog(
                        useRootNavigator: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Add a new task"),
                            actions: [
                              TextField(
                                onChanged: (value) => task = value,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  labelText: "Enter task",
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () async {
                                    if (task == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Please Enter A Task")));
                                    } else {
                                      if (snapshot.data.data().length == 1) {
                                        Map<String, dynamic> _map = {
                                          "info": {"Task 1": task}
                                        };
                                        FirebaseFirestore.instance
                                            .collection("user")
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                            .set(_map, SetOptions(merge: true));
                                      } else {
                                        Map<String, dynamic> _map =
                                            snapshot.data.data()["info"];
                                        _map["Task " +
                                            (snapshot.data
                                                        .data()["info"]
                                                        .length +
                                                    1)
                                                .toString()] = task;
                                        FirebaseFirestore.instance
                                            .collection("user")
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                            .set({"info": _map},
                                                SetOptions(merge: true));
                                      }
                                      Navigator.pop(context);
                                    }
                                    task = "";
                                  },
                                  child: Text(
                                    "Add",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
                /*
                return Column(
                  children: al.map(
                    (e) {
                      return card_data(tn: e, tv: _map![e]);
                    },
                  ).toList(),
                );
                */
              } catch (e) {
                return Center(
                  child: Text(
                    "ERROR",
                    style: TextStyle(fontSize: 50),
                  ),
                );
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
