import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jungle_gym/src/Onigo/OnigoPlaySurvivor.dart';
import 'package:jungle_gym/src/Onigo/OnigoResult.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Constants/Util.dart';
import '../Chats/rooms.dart';
import 'OnigoPlayOni.dart';

class CountDownPage extends StatefulWidget {
  const CountDownPage(
      {super.key, required this.roomNum, required this.gameTime});

  final int gameTime;
  final int roomNum;

  @override
  State<CountDownPage> createState() => _CountDownPage();
}

class _CountDownPage extends State<CountDownPage>
    with SingleTickerProviderStateMixin {
  bool initial = false;
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/lottie/countdown.json",
              controller: _anime,
              repeat: false,
              onLoaded: (composition) {
                _anime
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PlayingPage extends StatefulWidget {
  const PlayingPage({Key? key, required this.roomNum, required this.gameTime})
      : super(key: key);
  final int roomNum;
  final int gameTime;

  @override
  State<PlayingPage> createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {
  bool initial = false;
  int currentSeconds = 100;
  final firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    currentSeconds = widget.gameTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SlidingUpPanel(
          panel: const RoomsPage(),
          body: SingleChildScrollView(
            child: StreamBuilder(
              stream: firebase
                  .collection("Onigo")
                  .doc(widget.roomNum.toString())
                  .snapshots()
                  .map((doc) => doc.data()),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  var errors = snapshot.error!;
                  return Text(errors.toString());
                } else if (snapshot.hasData) {
                  var data = snapshot.data!;
                  return ChangeNotifierProvider<TimerModel>(
                      create: (_) => TimerModel(),
                      child: Consumer<TimerModel>(
                          builder: (context, model, child) {
                        if (!initial) {
                          model.start(currentSeconds);
                          initial = true;
                        }
                        if (model.displayTime == "finish") {
                          model.dispose();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ResultPage(roomId: widget.roomNum),
                              ),
                            );
                          });
                        }
                        if (oniMode(snapshot)) {
                          return OnigoPlayOni(
                            info: data,
                            displayTime: model.displayTime,
                          );
                        } else {
                          return OnigoPlaySurvivor(
                              info: data, displayTime: model.displayTime);
                        }
                      }));
                } else {
                  return const Text("Error");
                }
              },
            ),
          ),
        ));
  }

  bool oniMode(AsyncSnapshot snapshot) {
    final data = snapshot.data;
    final oniList = data["currentOni"];
    final uid = FirebaseAuth.instance.currentUser!.uid;

    var oniListString = [];

    for (var i in oniList) {
      oniListString.add(i.toString());
    }

    if (oniListString.contains(uid.toString())) {
      return true;
    } else {
      return false;
    }
  }
}
