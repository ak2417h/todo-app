import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  bool hp = false;

  Future signupmethod() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _pw,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
    final db = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({"name": _name});
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
            Color(0xFF6459E2),
            Colors.blue[400]!,
            Colors.blue[100]!,
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
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
                onChanged: (value) => setState(() {
                  _name = value;
                }),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
                onChanged: (value) => setState(() {
                  _email = value;
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 35),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                obscureText: hp,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      hp ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
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
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.8,
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
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /*
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.abc),
      ),
      */
    );
  }
}
