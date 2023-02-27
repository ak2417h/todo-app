import 'package:flutter/material.dart';
import 'package:todo_app/homepage.dart';
import 'signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          FirebaseAuth.instance.currentUser != null ? "login" : "login",
      routes: {
        "login": (context) => login(),
        "signup": (context) => signup(),
        "homepage": (context) => homepage(),
      },
    ),
  );
}
