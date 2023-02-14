import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Jinrou/JinrouHost.dart';
import '../KaigiFiles/JinrouKaigi.dart';
import '../KaigiFiles/OnigoKaigi.dart';
import '../Onigo/OnigoGuest.dart';
import '../Onigo/OnigoHost.dart';

class FirstPageClass {
  String lottieSelect(String name) {
    switch (name) {
      case "Onigo":
        return 'assets/lottie/run-forrest-run.json';
      case "Jinrou":
        return 'assets/lottie/wolf-of-wallstreet.json';
      default:
        return "";
    }
  }

  Future<int> initRoom(String name) async {
    Random random = Random();
    int roomNum = random.nextInt(9000) + 1000;
    final fu = FirebaseAuth.instance.currentUser!.uid;
    switch (name) {
      case "Onigo":
        final playOnigo = PlayOnigo.instance;

        Map<String, dynamic> rules = {
          "lose": 0,
          "num": 1,
          "time": 300,
          "return": false,
          "cooltime": 10,
        };

        await playOnigo.createGroupRoom(
          isPlaying: 0,
          roomNum: roomNum,
          users: [fu],
          rules: rules,
          ready: {fu : 1},
          host: fu,
          //currentOni: ["No one"],
        );
        return roomNum;
      case "Jinrou":
        final playJinrou = PlayJinrou.instance;

        Map<String, dynamic> rules = {
          "lose": 0,
          "num": 1,
          "time": 300,
          "return": false,
          "cooltime": 10,
        };

        await playJinrou.createGroupRoom(
          isPlaying: 0,
          roomNum: roomNum,
          users: [fu],
          rules: rules,
          ready: {fu : 1},
          host: fu,
          //currentOni: ["No one"],
        );
        return roomNum;
      default:
        return roomNum;
    }
  }

  chooseClass(String name){
    switch(name){
      case "Onigo":
        final playOnigo = PlayOnigo.instance;
        return playOnigo;
      case "Jinrou":
        final playJinrou = PlayJinrou.instance;
        return playJinrou;
      default:
        return null;
    }
  }

  Widget selectClass(int roomNum, String name) {
    switch (name) {
      case "Onigo":
        return OniRoomPage(roomNum: roomNum);
      case "Jinrou":
        return JinrouRoomPage(roomNum: roomNum);
      default:
        return Container();
    }
  }
  Widget selectGuest(int roomNum, String name){
    switch(name){
      case "Onigo":
        return EnterPage(roomNum: roomNum,);
      case "Jinrou":
        return EnterPage(roomNum: roomNum,);
      default:
        return Container();
    }
  }
  String returnString(String name){
    switch(name){
      case "Onigo":
        return "鬼ごっこ";
      case "Jinrou":
        return "人狼";
      default:
        return "Default";
    }
  }
}

/// The ready json identify whether the json is ready or not
/// ready 0 : not ready, 1 : ready
/// Class is to choose which widget and room number of it.