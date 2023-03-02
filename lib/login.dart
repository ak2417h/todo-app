import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String _email = "";
  String _pw = "";
  bool hp = true;

  Future<void> loginmethod() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _pw);
      Navigator.pushNamed(context, "homepage");
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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
                "Welcome\nBack",
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
                  labelText: "Email",
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
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                obscureText: hp,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  labelText: "Password",
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
                      text: "Don't Have An Account?",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "signup");
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
                onPressed: () => loginmethod(),
                child: Text(
                  "Login",
                  style: TextStyle(
                    // color: Colors.grey[600],
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              margin: EdgeInsets.only(top: 7.5),
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Forgot Password",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "forgotpass");
                          }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
