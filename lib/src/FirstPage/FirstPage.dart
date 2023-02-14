import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'FirstPageClass.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    super.key,
    required this.name,
    required this.controller,
    required this.anime,
    required this.color,
    required this.rules,
  });

  final Color color;
  final String name;
  final TextEditingController controller;
  final AnimationController anime;
  final Map<String, dynamic> rules;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final classes = FirstPageClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    classes.returnString(widget.name),
                    style: GoogleFonts.mochiyPopOne(
                      textStyle: const TextStyle(
                        fontSize: 48,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    child: Lottie.asset(
                      classes.lottieSelect(widget.name),
                      controller: widget.anime,
                      repeat: true,
                      onLoaded: (composition) {
                        // Configure the AnimationController with the duration of the
                        // Lottie file and start the animation.
                        widget.anime
                          ..duration = composition.duration
                          ..repeat();
                      },
                    ),
                  ),
                ),

                // The area to Create Room
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 30, right: 30, bottom: 0),
                  child: Container(
                    width: 130,
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        int roomNum = await classes.initRoom(widget.name);
                        var thisClass =
                            classes.selectClass(roomNum, widget.name);
                        if (!mounted) return;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => thisClass,
                          ),
                        );
                      },
                      child: Text("ルーム作成",
                          style: GoogleFonts.kosugiMaru(
                              /*textStyle: TextStyle()*/)),
                    ),
                  ),
                ),

                //The area to join room
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    width: 130,
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("ルーム番号入力"),
                              content: TextFormField(
                                controller: widget.controller,
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("戻る"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("参加"),
                                  onPressed: () async {
                                    if (kDebugMode) {
                                      print(widget.controller.text);
                                    }
                                    final firebase = FirebaseFirestore.instance;
                                    final fu =
                                        FirebaseAuth.instance.currentUser!.uid;

                                    try {
                                      var data = await firebase
                                          .collection(widget.name)
                                          .doc(widget.controller.text)
                                          .get();
                                      if (data.exists) {
                                        Map<String, dynamic> info =
                                            data.data()!;
                                        info["ready"][fu] = 1;
                                        final thisClass =
                                            classes.chooseClass(widget.name);
                                        await thisClass.updateRoom(info);
                                        final changingClass =
                                            classes.selectGuest(
                                                int.parse(
                                                    widget.controller.text),
                                                widget.name);
                                        if (!mounted) return;
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return changingClass;
                                            },
                                          ),
                                        );
                                      } else {
                                        const snackBar = SnackBar(
                                          content: Text('ルームが存在しません'),
                                        );
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                      const snackBar = SnackBar(
                                        content: Text('不明なエラー発生'),
                                      );
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text("ルーム参加", style: GoogleFonts.kosugiMaru()),
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
}
