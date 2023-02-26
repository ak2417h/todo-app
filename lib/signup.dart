import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  String _email = "";
  String _pw = "";

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Email"),
              onChanged: (value) => setState(() {
                _email = value;
              }),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Password"),
              onChanged: (value) => setState(() {
                _pw = value;
              }),
            ),
            TextButton(onPressed: () => signupmethod(), child: Text("Sign Up")),
          ],
        ),
      ),
    );
  }
}
