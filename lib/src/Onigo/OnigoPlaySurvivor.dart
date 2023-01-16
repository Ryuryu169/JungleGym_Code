import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Constants/Util.dart';
import '../HomePage/Homepage.dart';

class OnigoPlaySurvivor extends StatefulWidget {
  const OnigoPlaySurvivor(
      {super.key, required this.info, required this.displayTime});

  final String displayTime;
  final Map<String, dynamic> info;

  @override
  State<OnigoPlaySurvivor> createState() => _OnigoPlaySurvivor();
}

class _OnigoPlaySurvivor extends State<OnigoPlaySurvivor> {
  bool initial = false;
  late TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Exit Game"),
                              content: const Text("Are you sure?"),
                              actions: [
                                TextButton(
                                  child: const Text("Sure"),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const HomePage(),
                                      ),
                                    );
                                  },
                                ),
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: const Text(
                      '中止',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    )),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '残り時間:',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.displayTime,
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            //})),
            const SizedBox(
              height: 300,
              child: Image(
                image: AssetImage("assets/images/playerIcon.png"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              color: Colors.white,
              child: TextField(
                maxLength: 3,
                maxLines: 1,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: 'コードを入力',
                ),
                controller: _textController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () async {
                await updateOni();
              },
              child: const Text(
                '交代',
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateOni() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> data = widget.info;
    Map<String, dynamic> codeMap = data["code"];
    int num = int.parse(_textController.text);

    if (codeMap.containsValue(num)) {
      for (var i in codeMap.keys) {
        if (codeMap[i] == num) {
          GeneralUse util = GeneralUse();

          //data["code"].removeWhere((key, value) => key == i);
          //data["currentOni"].removeWhere((key) => key == i);
          data["code"][uid] = util.randomCode(data["code"]);
          data["currentOni"].add(uid);

          await FirebaseFirestore.instance
              .collection("Onigo")
              .doc(data["roomNum"].toString())
              .update(data);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wrong Code"),
        ),
      );
    }
  }
}
