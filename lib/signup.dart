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
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.33,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                decoration: InputDecoration(hintText: "Email"),
                onChanged: (value) => setState(() {
                  _email = value;
                }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                decoration: InputDecoration(hintText: "Password"),
                onChanged: (value) => setState(() {
                  _pw = value;
                }),
              ),
            ),
            Container(
                child: TextButton(
                    onPressed: () => signupmethod(),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.black),
                    ))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Container(
              child: Text("HI"),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.abc),
      ),
    );
  }
}
