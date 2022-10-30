import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class PlayingPage extends StatefulWidget {
  const PlayingPage({Key? key}) : super(key: key);

  @override
  State<PlayingPage> createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {
  bool oni=false;
  int hour=0;
  int minute=30;
  int Onisec=10;
  int code=0;
  int Onicode=0;
  late Timer _timer;
  late DateTime _time;
  late Timer _Onitimer;
  late DateTime _Onitime;


  @override
  void initState() {
    Onicode=Random().nextInt(999);
    _time = DateTime(0,0,0,hour,minute);
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1), // 1秒毎に定期実行
          (Timer timer) {
        setState(() { // 変更を画面に反映するため、setState()している
          if(_time!=DateTime(0,0,0,0,0,0))_time = _time.subtract(const Duration(seconds: 1));
        });
      },
    );
    _Onitime = DateTime(0,0,0,0,0,Onisec);
    super.initState();
    _Onitimer = Timer.periodic(
      const Duration(seconds: 1), // 1秒毎に定期実行
          (Timer timer) {
        setState(() { // 変更を画面に反映するため、setState()している
          if(_Onitime!=DateTime(0,0,0,0,0,0))_Onitime = _Onitime.subtract(const Duration(seconds: 1));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if(oni==true){
      return Scaffold(
        body:SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/BGofPlayingPage/playingTwo.png'),
                  fit: BoxFit.cover,
                )),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: (){},
                          child: const Text(
                            '中止',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          )),
                      const SizedBox(width: 20,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '残り時間:',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        DateFormat.Hm().format(_time),
                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 420,),
                  Text(
                    'コード：$Onicode',
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  if(_Onitime!=DateTime(0,0,0,0,0,0))Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '待機タイマー:',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        DateFormat.s().format(_Onitime),
                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

      );
    } else if(oni==false){
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/BGofPlayingPage/playingOne.png'),
                  fit: BoxFit.cover,
                )),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: (){},
                          child: const Text(
                            '中止',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          )),
                      const SizedBox(width: 20,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '残り時間:',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        DateFormat.Hm().format(_time),
                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 430,),
                  Container(
                    width: MediaQuery.of(context).size.width-100,
                    color: Colors.white,
                    child: TextField(
                      maxLength: 3,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        hintText: 'コードを入力',
                      ),
                      onChanged: (value){
                        code=int.parse(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: (){

                      },
                      child: const Text(
                        '交代',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ),

      );
    }else {
      return const Scaffold(
        body:Center(
          child:Text(
            'エラー',
            style: TextStyle(
              fontSize: 80,
              color: Colors.red,
            ),
          ),
        ),
      );
    }
  }
}