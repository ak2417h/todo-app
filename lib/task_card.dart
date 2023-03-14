import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class card_info extends StatefulWidget {
  // const test({super.key});
  dynamic idk;
  Function delete;
  card_info({required this.idk, required this.delete});

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
      return Column(
        children: alist.map((e) {
          final textcontroller = TextEditingController(text: _map[e]);
          return Card(
            child: Container(
              width: 339,
              height: 100 / 2,
              child: TextField(
                controller: textcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.delete_rounded),
                ),
              ),
            ),
            /*
            child: TextFormField(
              initialValue: _map[e],
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => setState(
                    () {
                      widget.delete(e);
                    },
                  ),
                  icon: Icon(Icons.delete_rounded),
                ),
              ),
              onChanged: (value) {},
            ),
            */
          );
        }).toList(),
      );
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
