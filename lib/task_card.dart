import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class card_info extends StatefulWidget {
  // const test({super.key});
  dynamic idk;
  Function delete;
  Function change;
  card_info({required this.idk, required this.delete, required this.change});

  @override
  State<card_info> createState() => _card_infoState();
}

class _card_infoState extends State<card_info> {
  @override
  Widget build(BuildContext context) {
    try {
      if (widget.idk.length != 0) {
        Map<String, dynamic> _map = widget.idk;
        List alist = widget.idk.keys.toList();
        alist.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
        return Column(
          children: alist.map((e) {
            String temp_str = _map[e];
            final textcontroller = TextEditingController(text: temp_str);
            textcontroller.value = textcontroller.value.copyWith(
              text: temp_str,
              selection: TextSelection.fromPosition(
                TextPosition(offset: temp_str.length),
              ),
            );
            return Card(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 100 / 2,
                child: TextFormField(
                  // initialValue: temp_str,
                  controller: textcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.delete_rounded),
                      onPressed: () {
                        return widget.delete(e);
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      temp_str = value;
                      // final val = TextSelection.collapsed(
                      //     offset: textcontroller.text.length);
                      // textcontroller.selection = val;
                      // textcontroller.value = textcontroller.value.copyWith(
                      //   text: value,
                      //   selection: TextSelection.fromPosition(
                      //     TextPosition(offset: value.length),
                      //   ),
                      // );
                    });
                    return widget.change(e, value);
                  },
                ),
              ),
            );
          }).toList(),
        );
      } else {
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
    } catch (e) {
      return Center(
        child: Text(e.toString()),
      );
    }
  }
}
