// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'dart:async';
// import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(acc_setting());
}

class acc_setting extends StatefulWidget {
  const acc_setting({super.key});

  @override
  State<acc_setting> createState() => _acc_settingState();
}

class _acc_settingState extends State<acc_setting> {
  @override
  final user = FirebaseAuth.instance.currentUser;
  // String email = user?.email;
  String email = "";
  var fieldText = TextEditingController(
      text: FirebaseAuth.instance.currentUser?.email.toString());
  final fieldText2 = TextEditingController(text: "");
  bool show = false;
  String password = "";

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // GoogleSignIn().signOut();
      Navigator.pushNamed(context, "login");
    } catch (e) {
      Navigator.pushNamed(context, "login");
    }
  }

  Future<void> _press(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Text("Account Deletion"),
            // content: Text("enter first and last name"),
            actions: <Widget>[
              Container(
                  alignment: Alignment.center,
                  child: Text(
                      "Are you sure you want to delete your account?\nYou cannot undo this action.")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: TextButton(
                      child: Text(
                        "Delete Account",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () async {
                        try {
                          FirebaseFirestore.instance
                              .collection("user")
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .delete();
                          // await user?.reauthenticateWithCredential();
                          await user?.delete();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Account successfully deleted")));
                          Navigator.pushNamed(context, "signup");
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                          signOut();
                        }
                      },
                    ),
                  ),
                  Container(
                    child: TextButton(
                      child: Text(
                        "Cancel",
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(255, 255, 255, 12),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.indigo[300],
        ),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Container(
              child: Text(
                "Account Settings",
                style: TextStyle(fontSize: 50),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7.5,
            ),
            Container(
              width: 350,
              child: TextField(
                controller: fieldText,
                // enabled: false,
                // initialValue: email,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear), // clear text
                    onPressed: () => fieldText.clear(),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  hintText: "Change email",
                ),
                onChanged: (value) => email = fieldText.text.toString(),
              ),
              margin: EdgeInsets.only(bottom: 15),
            ),
            Container(
              width: 350,
              child: TextField(
                controller: fieldText2,
                obscureText: !show,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    // Icon to
                    icon: Icon(show
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined), // clear text
                    onPressed: () => setState(() {
                      show = !show;
                    }),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      // width: 3,
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      // width: 3,
                      color: Colors.white,
                    ),
                  ),
                  hintText: "Change password",
                ),
                onChanged: (value) => password = fieldText2.text.toString(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 350,
              // width: 225,
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(15),
                    // ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    try {
                      if ((email == "" ||
                              email ==
                                  FirebaseAuth.instance.currentUser?.email) &&
                          (password == "" || password == null)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Please enter an email and/or password")));
                      } else {
                        if ((email != "" &&
                            email != FirebaseAuth.instance.currentUser?.email))
                          await user?.updateEmail(email);
                        else {
                          await user?.updatePassword(password);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("All changes saved")));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                      // signOut();
                    }
                  }),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
              width: 350,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[600]),
                ),
                child: Text(
                  "Delete Account",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _press(context),
              ),
            ),
            Container(
              width: 350,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.indigo[700]),
                ),
                child: Text(
                  "Signout",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => signOut(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
