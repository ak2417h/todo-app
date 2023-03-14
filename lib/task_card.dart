import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class card_info extends StatefulWidget {
  // const test({super.key});
  dynamic idk;

  card_info({required this.idk});

  @override
  State<card_info> createState() => _card_infoState();
}

class _card_infoState extends State<card_info> {
  @override
  Widget build(BuildContext context) {
    try {
      Map<String, dynamic> _map = widget.idk;
      List alist = widget.idk.keys.toList();
      alist.sort();
      if (widget.idk == null) {
        return Center();
      } else {
        return Column(
          children: alist.map((e) {
            return Text(e);
          }).toList(),
        );
      }
    } catch (e) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
          ),
          Container(
            child: Text(
              "ADD A TASK",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            alignment: Alignment.center,
          ),
        ],
      );
    }
  }
}
