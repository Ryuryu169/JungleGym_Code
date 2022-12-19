import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../Constants/kaigi.dart';
import '../HomePage/homepage.dart';
import 'Controller.dart';

/// A class for creating a game room.

class OniRoomPage extends StatefulWidget {
  const OniRoomPage({Key? key, required this.roomNum}) : super(key: key);
  final int roomNum;

  @override
  State<OniRoomPage> createState() => _OniRoomPageState();
}

class _OniRoomPageState extends State<OniRoomPage> {
  final firebase = FirebaseFirestore.instance;
  final onigo = PlayOnigo.instance;

  int playerNumInit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () async {
            try {
              await onigo.deleteRoom(widget.roomNum.toString());
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
            if (!mounted) return;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<Map<String, dynamic>?>(
          stream: firebase
              .collection("Onigo")
              .doc(widget.roomNum.toString())
              .snapshots()
              .map((doc) => doc.data()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              var users = data['userIds'];
              var rules = data["rules"];
              int oniNum = rules["num"];
              int minute = rules["time"] ~/ 60;
              int second = rules["time"] % 60;
              String time = '$minute : ${second.toString().padLeft(2, "0")}';

              return FutureBuilder<List<String>>(
                future: findUser(users),
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    playerNumInit =
                        snapshot2.data!.isNotEmpty ? snapshot2.data!.length : 2;
                    // print(snapshot.data);
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child:
                                    Text("Room Number is ${widget.roomNum}")),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child:
                                    Text("Number of players $playerNumInit")),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 80, right: 80),
                              child: Container(
                                decoration: BoxDecoration(
                                  //color: Colors.grey[300],
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(40),
                                  child: Center(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot2.data?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Text(
                                          snapshot2.data![index],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Oni number ${snapshot.data!["rules"]["num"]}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Time $time',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Cooltime ${snapshot.data!["rules"]["cooltime"]}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () {
                                  var num = rules["time"] / 60;
                                  var oniNum = rules["num"];
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Settings"),
                                        content: StatefulBuilder(
                                            builder: (context, setState) {
                                          return Column(
                                            children: [
                                              NumberPicker(
                                                value: num,
                                                minValue: 1,
                                                maxValue: 20,
                                                onChanged: (value) =>
                                                    setState(() => num = value),
                                              ),
                                              NumberPicker(
                                                value: oniNum,
                                                minValue: 1,
                                                maxValue: users.length,
                                                onChanged: (value) => setState(
                                                    () => oniNum = value),
                                              ),
                                            ],
                                          );
                                        }),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              rules["time"] = num * 60;
                                              rules["num"] = oniNum;

                                              await firebase
                                                  .collection("Onigo")
                                                  .doc(
                                                      widget.roomNum.toString())
                                                  .update({"rules": rules});

                                              if(!mounted) return;
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Save"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text("Change Rule"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Starting"),
                                        content: const Text("Are you sure?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              // This function creates a list of random players.
                                              // You can add the number of tags by increasing the oniNum.
                                              var oniPlayers = returnRandom(
                                                  users, users.length, oniNum);

                                              // You add the information to the Firebase, and change the state to getting ready.
                                              await firebase
                                                  .collection("Onigo")
                                                  .doc(
                                                      widget.roomNum.toString())
                                                  .update(
                                                {
                                                  "currentOni": oniPlayers,
                                                  "isPlaying": 1,
                                                  "rules": rules,
                                                  "updatedAt": FieldValue
                                                      .serverTimestamp(),
                                                },
                                              );
                                              if (!mounted) return;
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Controller(
                                                          roomNum:
                                                              widget.roomNum),
                                                ),
                                              );
                                            },
                                            child: const Text("Start"),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text("Start Game"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              );
            } else {
              return const Text("No data");
            }
          },
        ),
      ),
    );
  }

  List<String>? returnRandom(List listPlayers, int playerNum, int oniNum) {
    List<String> oniPlayer = [];
    List<int> oni = [];

    for (int i = 0; i < oniNum; i++) {
      Random random = Random();
      int num = random.nextInt(playerNum);
      if (oni.isEmpty) {
        while (oni.contains(num)) {
          num = random.nextInt(playerNum);
        }
      }
      oni.add(num);
      oniPlayer.add(listPlayers[num]);
    }
    return oniPlayer;
  }

  Future<List<String>> findUser(List<dynamic> uid) async {
    List<String> names = [];
    for (var d in uid) {
      final cu = await firebase.collection("users").doc(d.toString()).get();
      final data = cu.data();
      names.add(data!["firstName"].toString());
    }
    return names;
  }
}
