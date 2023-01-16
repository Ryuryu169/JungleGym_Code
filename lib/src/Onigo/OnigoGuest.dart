import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jungle_gym/src/Onigo/OnigoPlay.dart';
import 'package:lottie/lottie.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../Constants/Util.dart';
import '../KaigiFiles/OnigoKaigi.dart';

class EnterPage extends StatefulWidget {
  const EnterPage({super.key, required this.roomNum});

  final int roomNum;

  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  final firebase = FirebaseFirestore.instance;
  final onigo = PlayOnigo.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("鬼ごっこ"),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                return const Text("Error");
              } else if (snapshot.hasData) {
                var data = snapshot.data!;
                var users = data['userIds'];
                var rules = data["rules"];
                int oniNum = rules["num"];
                int minute = rules["time"] ~/ 60;
                int second = rules["time"] % 60;
                String time =
                    '${minute.toString()} : ${second.toString().padLeft(
                    2, "0")}';

                return FutureBuilder<List<String>>(
                  future: findUser(users),
                  builder: (context, snapshot2) {
                    if (snapshot2.hasData) {
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
                                  child: Text(
                                      "Number of players ${widget.roomNum}")),
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
                                  'Oni number $oniNum',
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
                                  'Cooltime ${snapshot
                                      .data!["rules"]["cooltime"]}',
                                ),
                              ),
                              /*Padding(
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
                                                      setState(
                                                          () => num = value),
                                                ),
                                                NumberPicker(
                                                  value: oniNum,
                                                  minValue: 1,
                                                  maxValue: users.length,
                                                  onChanged: (value) =>
                                                      setState(
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
                                                    .doc(widget.roomNum
                                                        .toString())
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
                              ),*/
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Ready"),
                                          content: const Text("Are you ready?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                final fu = FirebaseAuth
                                                    .instance.currentUser!.uid;
                                                Map<String, dynamic> info =
                                                Map<String, dynamic>.from(
                                                    data);
                                                info["ready"][fu] = 1;
                                                bool i = checkReadySubmit(info);
                                                if (i) info["isPlaying"] = 1;

                                                onigo.updateRoom(info);
                                                if (!mounted) return;
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                        context) =>
                                                            WaitingUser(
                                                                roomNum: widget
                                                                    .roomNum)));
                                              },
                                              child: const Text("Ready"),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text("Ready"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Text("No Data");
                    }
                  },
                );
              } else {
                return const Text("Error");
              }
            },
          ),
        ),
      ),
    );
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

  bool checkReadySubmit(Map<String, dynamic> info) {
    bool allReady = true;
    Map<String, dynamic> ready = info["ready"];
    for (String i in ready.keys) {
      if (ready[i] == 0) {
        allReady = false;
      }
    }
    return allReady;
  }
}

class WaitingUser extends StatefulWidget {
  const WaitingUser({super.key, required this.roomNum});

  final int roomNum;

  @override
  State<WaitingUser> createState() => _WaitingUser();
}

class _WaitingUser extends State<WaitingUser>
    with SingleTickerProviderStateMixin {
  late AnimationController _anime;

  @override
  void initState() {
    _anime = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _anime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>?>(
        stream: FirebaseFirestore.instance
            .collection("Onigo")
            .doc(widget.roomNum.toString())
            .snapshots()
            .map((doc) => doc.data()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text("Error Occurred!");
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            if (data!["isPlaying"] != 1) {
              return waitingNow(data);
            } else {
              final info = snapshot.data;
              final rules = info!["rules"];
              final gameTime = rules["time"];
              return FutureBuilder<bool>(
                future: waiting(),
                builder: (context, snapshot) {
                  //if (!snapshot.hasData) {
                  //  return CountDownPage(roomNum: widget.roomNum, gameTime: gameTime);
                  //}
                  return PlayingPage(
                    roomNum: widget.roomNum,
                    gameTime: gameTime,
                  );
                },
              );
            }
          } else {
            return const Text("No Data!");
          }
        });
  }

  Future<bool> waiting() async {
    Future.delayed(const Duration(seconds: 5),);
    return true;
  }

  Widget waitingNow(Map<String, dynamic> info) {
    final ready = info["ready"];
    final listPl =
    ready.entries.map((e) => WaitingPlayers(e.key, e.value)).toList();
    final num = listPl.length;

    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: findUser(listPl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text("Data has Error");
          } else if (!snapshot.hasData) {
            return const Text("No Data");
          } else {
            final GeneralUse util = GeneralUse();
            final data = snapshot.data;
            for (int i = 0; i < data!.length; i++) {
              listPl[i].name = data[i];
            }
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(50),
                          child: Text(util.checkWaiting(info),
                              style: const TextStyle(fontSize: 20))),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: allReadyLottie(info),
                      ),
                    ],
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: num,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Expanded(flex: 6, child: util.checkReady(listPl, index)),
                          Expanded(
                              flex: 2, child: util.showText(listPl, index, "name")),
                          Expanded(
                              flex: 2, child: util.showText(listPl, index, "key")),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget allReadyLottie(Map<String, dynamic> data) {
    if (data["isPlaying"] == 1) {
      return SizedBox(
        width: 200,
        height: 200,
        child: Lottie.asset(
          "assets/lottie/ready-to-go.json",
          controller: _anime,
          repeat: true,
          onLoaded: (composition) {
            _anime
              ..duration = composition.duration
              ..repeat();
          },
        ),
      );
    } else {
      return SizedBox(
        width: 200,
        height: 200,
        child: Lottie.asset(
          "assets/lottie/waiting.json",
          controller: _anime,
          repeat: true,
          onLoaded: (composition) {
            _anime
              ..duration = composition.duration
              ..repeat();
          },
        ),
      );
    }
  }

  Future<List<String>> findUser(List<dynamic> uid) async {
    final firebase = FirebaseFirestore.instance;
    List<String> names = [];
    for (var d in uid) {
      final cu =
      await firebase.collection("users").doc(d.name.toString()).get();
      final data = cu.data();
      names.add(data!["firstName"].toString());
    }
    return names;
  }
}

class WaitingPlayers {
  String name;
  int key;

  WaitingPlayers(this.name, this.key);
}
