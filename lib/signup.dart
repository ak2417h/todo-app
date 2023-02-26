import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String email = "";
  String pw = "";
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
                email = value;
              }),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Password"),
              onChanged: (value) => setState(() {
                pw = value;
              }),
            ),
            TextButton(onPressed: () => null, child: Text("Sign Up")),
            Text(email + " " + pw + " firebase")
          ],
        ),
      ),
    );
  }
}
