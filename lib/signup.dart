import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String _name = "";
  String _email = "";
  String _pw = "";
  bool hp = true;

  Future signupmethod() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _pw,
      );
      FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"name": _name});
      // FirebaseFirestore.instance
      //   .collection("user")
      //   .doc(FirebaseAuth.instance.currentUser!.uid)
      //   .set({"info": {"Task 1" : " "}},SetOptions(merge: true));
      Navigator.pushNamed(context, "mainpage");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo[600]!,
            Colors.indigo[400]!,
            Colors.indigo[100]!,
            // Color(0xFF6459E2),
            // Colors.blue[400]!,
            // Colors.blue[100]!,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 35),
              child: Text(
                "Create\nAccount",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                cursorColor: Colors.grey[800],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                  labelText: "Name",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey[800],
                  ),
                ),
                onChanged: (value) => setState(() {
                  _name = value;
                }),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                cursorColor: Colors.grey[800],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey[800],
                  ),
                ),
                onChanged: (value) => setState(() {
                  _email = value;
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                cursorColor: Colors.grey[800],
                obscureText: hp,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey[800],
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      hp ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                      color: Colors.grey[800],
                    ),
                    onPressed: () => setState(() {
                      hp = !hp;
                    }),
                  ),
                ),
                onChanged: (value) => setState(() {
                  _pw = value;
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              width: MediaQuery.of(context).size.width * 0.85,
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Already Have An Account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "login");
                        }),
                ]),
              ),
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                onPressed: () => signupmethod(),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    // color: Colors.grey[600],
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
