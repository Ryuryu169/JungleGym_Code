import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Chats/rooms.dart';
import '../HomePage/Homepage.dart';

class OnigoPlayOni extends StatefulWidget {
  const OnigoPlayOni(
      {super.key, required this.info, required this.displayTime});

  final String displayTime;
  final Map<String, dynamic> info;

  @override
  State<OnigoPlayOni> createState() => _OnigoPlayOni();
}

class _OnigoPlayOni extends State<OnigoPlayOni> {
  bool initial = false;
  final uid = FirebaseAuth.instance.currentUser!.uid;

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
            const SizedBox(
              height: 300,
              child: Image(
                image: AssetImage("assets/images/oniIcon.png"),
              ),
            ),
            Text(
              'コード：${widget.info["code"][uid].toString()}',
              style: const TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '待機タイマー:',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.info["currentTime"] ?? "05:00",
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                  ),
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
