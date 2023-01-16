import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

import 'package:flutter/material.dart';

class OniReadyTime extends ChangeNotifier {
  int currentSeconds = 5;

  void start() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        currentSeconds -= 1;
        if(currentSeconds == 0) return;
      },
    );
  }
}

class TimerModel extends ChangeNotifier {
  String displayTime = "";
  late Timer timer;

  void start(int rulesTime) {
    int currentSeconds = rulesTime;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        currentSeconds -= 1;

        int seconds = currentSeconds % 60;
        int minutes = currentSeconds ~/ 60;

        displayTime =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";

        if(currentSeconds == 298){
          timer.cancel();
          displayTime = "finish";
          notifyListeners();
          return;
        }
        notifyListeners();
      },
    );
  }
}

class GeneralUse {
  final firebase = FirebaseFirestore.instance;

  Future<List<String>> findUser(List<dynamic> uid) async {
    List<String> names = [];
    for (var d in uid) {
      final cu = await firebase.collection("users").doc(d.toString()).get();
      final data = cu.data();
      names.add(data!["firstName"].toString());
    }
    return names;
  }
  Future<List<String>> findId(List<dynamic> uid) async {
    List<String> names = [];
    for(var d in uid) {
      final cu = await firebase.collection("users").doc(d.toString()).get();
      final data = cu.data();
      names.add(data!["lastName"].toString());
    }
    return names;
  }

  int randomCode(Map<String, dynamic> data){
    Random random = Random();
    int num = 0;
    if(data.isNotEmpty){
      print(data);
      //do {
        num = random.nextInt(900) + 100;
      //} while(data["code"].containsValue(num));
      print(data["code"].containsValue(num));
    } else{
      num = random.nextInt(900) + 100;
    }
    return num;
  }

  Widget showText(List<dynamic> list, int index, String type) {
    final data = list[index];
    switch (type) {
      case "name":
        return Text(data.name);
      case "key":
        return Text(data.key.toString());
      default:
        return Container();
    }
  }

  String checkWaiting(Map<String, dynamic> info) {
    if (info["isPlaying"] == 1) {
      return "Ready, waiting for host!";
    } else {
      return "Now waiting...";
    }
  }

  Widget checkReady(List<dynamic> data, index) {
    if (data[index].key == 1) {
      return const Icon(
        Icons.check,
        size: 100,
      );
    } else {
      return const Icon(
        Icons.close,
        size: 100,
      );
    }
  }
}
