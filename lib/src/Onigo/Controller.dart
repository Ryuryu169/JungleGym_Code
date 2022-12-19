import 'package:flutter/material.dart';

import '../HomePage/homepage.dart';
import 'PlayingPage.dart';

class Controller extends StatefulWidget {
  final int roomNum;
  const Controller({super.key, required this.roomNum});

  @override
  State<Controller> createState() => _Controller();
}

class _Controller extends State<Controller> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if(snapshot.hasError){
            return AlertDialog(
              content: const Text("Error Occurred! \n Going back to Home Page"),
              actions: [
                TextButton(
                    child: const Text("Back"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                    }),
              ],
            );
          } else {
            return PlayingPage(roomNum: widget.roomNum);
          }
        });
  }
}
