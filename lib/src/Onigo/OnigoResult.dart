import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Constants/Util.dart';
import '../HomePage/Homepage.dart';
//import 'OnigoHost.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.roomId}) : super(key: key);

  final int roomId;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  GeneralUse util = GeneralUse();
  final user = FirebaseAuth.instance.currentUser!.uid;
  bool win = false;
  bool showAnimation = true;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: waitForEnd(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return FutureBuilder<Map<String, dynamic>>(
            future: returnMap(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                final data = snapshot.data!;
                win = !data["currentOni"].contains(
                    FirebaseAuth.instance.currentUser!.uid.toString());
                return Scaffold(
                  backgroundColor: win == true ? Colors.red : Colors.black,
                  body: Center(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        const SizedBox(
                          width: 210,
                          height: 100,
                          child: Text(
                            'Result',
                            style: TextStyle(
                              fontFamily: 'RussoOne',
                              fontSize: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(60),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(400, 300),
                            ),
                          ),
                          child: Text(
                            win == true ? "勝利！" : "敗北...",
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: data["userIds"].length,
                            itemBuilder: (BuildContext context, int index) {
                              String userUid = data["idUser"][index];
                              return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    color: Colors.white,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: data["currentOni"]
                                                      .contains(user)
                                                  ? const Icon(
                                                      Icons.account_circle)
                                                  : Container()),
                                          Expanded(
                                              flex: 1, child: Padding(padding: const EdgeInsets.all(10),child: Text(userUid, textAlign: TextAlign.center,))),
                                        ]),
                                  ));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            },
                            child: const Text(
                              'ルームに戻る',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        //Expanded(child: Container()),
                      ],
                    ),
                  ),
                );
              }
              return const Text("No data");
            },
          );
        } else {
          return Lottie.asset(
            "assets/lottie/finished.json",
            controller: _animationController,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _animationController
                ..duration = composition.duration
                ..forward();
            },
          );
        }
      },
    );
  }

  Future<bool> waitForEnd() async {
    await Future.delayed(const Duration(milliseconds: 2300));
    return true;
  }

  Future<Map<String, dynamic>> returnMap() async {
    final data = await FirebaseFirestore.instance
        .collection("Onigo")
        .doc(widget.roomId.toString())
        .get();
    Map<String, dynamic> map = data.data()!;
    final userIds = await util.findId(map["userIds"]);
    map["idUser"] = userIds;

    return map;
  }
}
