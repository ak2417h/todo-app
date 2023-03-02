import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'start.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class mainpage extends StatefulWidget {
  const mainpage({super.key});

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  int ci = 0;

  Widget build(BuildContext context) {
    List<Widget> wl = [
      startClass(),
      home(),
      Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "login");
              },
              child: Text("Logout"),
            ),
            TextButton(
              onPressed: () async {
                final db = FirebaseFirestore.instance
                    .collection("user")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .delete()
                    .then((value) async {
                  await FirebaseAuth.instance.currentUser?.delete();
                  Navigator.pushNamed(context, "signup");
                });
              },
              child: Text("Delete Account"),
            )
          ],
        ),
      )
    ];
    return Scaffold(
      body: Container(
        child: wl.elementAt(ci),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ci,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Start",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          )
        ],
        onTap: (value) => setState(() {
          ci = value;
        }),
      ),
    );
  }
}
