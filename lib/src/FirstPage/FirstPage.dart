import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Jinrou/JinrouHost.dart';
import '../Onigo/OnigoGuest.dart';
import 'FirstPageClass.dart';

class FirstPage extends StatefulWidget {
  const FirstPage(
      {super.key,
      required this.name,
      required this.controller,
      required this.anime,
      required this.rules});

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
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 150,
                    height: 150,
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 30, right: 30, bottom: 0),
                  child: SizedBox(
                    width: 130,
                    height: 40,
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Enter Room Number"),
                              content: TextFormField(
                                controller: widget.controller,
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Back"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("Join"),
                                  onPressed: () async {
                                    if (kDebugMode) {
                                      print(widget.controller.text);
                                    }
                                    final firebase = FirebaseFirestore.instance;
                                    final fu = FirebaseAuth.instance.currentUser!.uid;

                                    try {
                                      var data = await firebase
                                          .collection(widget.name)
                                          .doc(widget.controller.text)
                                          .get();
                                      if (data.exists) {
                                        Map<String, dynamic> info = data.data()!;
                                        info["ready"][fu] = 1;
                                        final thisClass = classes.chooseClass(widget.name);
                                        await thisClass.updateRoom(info);
                                        final changingClass = classes.selectGuest(int.parse(widget.controller.text), widget.name);
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
                                          content: Text('Did not found room'),
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
                                        content: Text('Due to error did not found room'),
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
}
