import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../Constants/kaigi.dart';
import 'Onigo.dart';

class FirstTag extends StatefulWidget {
  const FirstTag({super.key});

  @override
  State<FirstTag> createState() => _FirstTagState();
}

class _FirstTagState extends State<FirstTag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text("鬼ごっこ", style: TextStyle(fontSize: 24)),
                ),
                rules(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 30, right: 30, bottom: 0),
                  child: SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        Random random = Random();
                        int roomNum = random.nextInt(10000);
                        await initRoom(roomNum);
                        if(!mounted) return;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OniRoomPage(roomNum:roomNum),
                          ),
                        );
                      },
                      child: const Text("Create Room"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Join Room"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rules() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        'Rules:Hello!',
        textAlign: TextAlign.center,
      ),
    );
  }
  Future<int> initRoom(int roomNum) async {
    final firebaseAuth = FirebaseAuth.instance;
    final playOnigo = PlayOnigo.instance;

    Map<String, dynamic> rules = {
      "lose": 0,
      "num": 1,
      "time": 300,
      "return": false,
      "cooltime": 10,
    };

    final fu = firebaseAuth.currentUser!.uid;

    await playOnigo.createGroupRoom(
      isPlaying: 0,
      roomNum: roomNum,
      users: [fu],
      rules: rules,
    );
    return roomNum;
  }
}
