import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../Constants/Util.dart';
import '../HomePage/Homepage.dart';
import '../KaigiFiles/JinrouKaigi.dart';
import '../Onigo/OnigoGuest.dart';

class JinrouRoomPage extends StatefulWidget {
  const JinrouRoomPage({super.key, required this.roomNum});
  final int roomNum;

  @override
  State<JinrouRoomPage> createState() => _JinrouRoomPage();
}

class _JinrouRoomPage extends State<JinrouRoomPage> {
  final firebase = FirebaseFirestore.instance;
  final GeneralUse util = GeneralUse();
  final PlayJinrou jinrou = PlayJinrou.instance;
  Random random = Random();

  int playerNumInit = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () async {
            try {
              await jinrou.deleteRoom(widget.roomNum.toString());
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
              final ready = data["ready"];
              final GeneralUse util = GeneralUse();
              final listPl = ready.entries
                  .map((e) => WaitingPlayers(e.key, e.value))
                  .toList();
              final num = listPl.length;
              var users = data['userIds'];
              var rules = data["rules"];
              int oniNum = rules["num"];
              int minute = rules["time"] ~/ 60;
              int second = rules["time"] % 60;
              String time = '$minute : ${second.toString().padLeft(2, "0")}';

              return FutureBuilder<List<String>>(
                future: util.findUser(users),
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    playerNumInit =
                    snapshot2.data!.isNotEmpty ? snapshot2.data!.length : 2;
                    // print(snapshot.data);
                    final names = snapshot2.data;
                    for (int i = 0; i < names!.length; i++) {
                      listPl[i].name = names[i];
                    }
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
                              //child: SingleChildScrollView(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                      itemCount: num,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Expanded(
                                                flex: 6,
                                                child: util.checkReady(
                                                    listPl, index)),
                                            Expanded(
                                                flex: 2,
                                                child: util.showText(
                                                    listPl, index, "name")),
                                            Expanded(
                                                flex: 2,
                                                child: util.showText(
                                                    listPl, index, "key")),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              //),
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

                                              if (!mounted) return;
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
                                              if (data["isPlaying"] == 1) {
                                                final now = DateTime.now();
                                                final endTime = now.add(
                                                  Duration(
                                                    minutes: (rules["time"] / 60).round(),
                                                  ),
                                                );
                                                var oniPlayers = returnRandom(
                                                    users,
                                                    users.length,
                                                    oniNum);
                                                Map<String, dynamic> codeMap =
                                                randomCode(oniPlayers!);

                                                // You add the information to the Firebase, and change the state to getting ready.
                                                await firebase
                                                    .collection("Onigo")
                                                    .doc(widget.roomNum
                                                    .toString())
                                                    .update(
                                                  {
                                                    "code": codeMap,
                                                    "endTime": endTime,
                                                    "currentOni": oniPlayers,
                                                    "isPlaying": 2,
                                                    "rules": rules,
                                                    "updatedAt": FieldValue
                                                        .serverTimestamp(),
                                                  },
                                                );
                                                if (!mounted) return;
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage(),//TODO: change this to play page
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Not Ready yet")));
                                              }
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
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await firebase
                                      .collection("Onigo")
                                      .doc(widget.roomNum
                                      .toString())
                                      .update(
                                    {
                                      "isPlaying": 1,
                                      "updatedAt": FieldValue
                                          .serverTimestamp(),
                                    },
                                  );
                                  if(!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Updated"),));
                                },
                                child: const Text("Debug"),
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
              return Text("No data ${widget.roomNum.toString()}");
            }
          },
        ),
      ),
    );
  }
  List<String>? returnRandom(List listPlayers, int playerNum, int oniNum) {
    List<String> oniPlayer = [];
    List<int> jinrou = [];

    for (int i = 0; i < oniNum; i++) {
      int num = random.nextInt(playerNum);
      if (jinrou.isEmpty) {
        while (jinrou.contains(num)) {
          num = random.nextInt(playerNum);
        }
      }
      jinrou.add(num);
      oniPlayer.add(listPlayers[num]);
    }
    return oniPlayer;
  }

  Map<String, dynamic> randomCode(List<String> jinrouPlayer) {
    Map<String, dynamic> codeMap = {};

    for (var i in jinrouPlayer) {
      codeMap[i] = util.randomCode(codeMap);
    }
    return codeMap;
  }
}