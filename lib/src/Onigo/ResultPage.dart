import 'package:flutter/material.dart';

import 'Onigo.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool win = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60,),
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
                    Radius.elliptical(400,300),
                  ),
                ),
                child: resultText(win),
              ),
              const SizedBox(height: 180,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OniRoomPage(roomNum:20),
                      ));},
                child: const Text(
                  'ルームに戻る',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget resultText(bool win) {
    if(win==true){
      return Text(
        '勝利！!',
        style: TextStyle(
          fontSize: 80,
          color: Colors.red[900],
        ),
      );
    }
    else {
      return Text(
        '敗北…',
        style: TextStyle(
          fontSize: 80,
          color: Colors.indigo[900],
        ),
      );
    }
  }
}