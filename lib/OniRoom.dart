import 'package:flutter/material.dart';
import 'dart:math';

import 'PlayingPage.dart';

class OniRoomPage extends StatefulWidget {
  const OniRoomPage({Key? key}) : super(key: key);

  @override
  State<OniRoomPage> createState() => _OniRoomPageState();
}

class _OniRoomPageState extends State<OniRoomPage> {
  int RoomNum=Random().nextInt(9999);//部屋番号
  int MemberNum=members.length;//参加人数
  int OniNum=1;//鬼の人数
  int LimitTime=30;//制限時間
  int StayTime=10;//鬼の待機時間
  List<int> OniNumlist=List<int>.generate(members.length-1, (index) => (index+1));//鬼の人数選択肢
  List<int>LimitTimelist=[for(int i=10;i<181;i=i+5)i];//制限時間選択肢
  List<int>StayTimelist=List<int>.generate(30,(index)=>(index+1));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child:Center(
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SizedBox(
                height: 60,
                child:Text(
                  '部屋番号：$RoomNum',
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Text(
                  '参加人数：$MemberNum人',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              const SizedBox(
                height: 30,
                child: Text(
                  '参加者',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width-30,
                height: 210,
                child: ListView.builder(
                    itemCount: MemberNum,
                    itemBuilder:(BuildContext context, int index) {
                      return SizedBox(
                        height: 30,
                        child: Text(
                          members[index],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10,bottom: 5),
                    width: MediaQuery.of(context).size.width-120,
                    height: 50,
                    child: const Text(
                      '鬼の人数',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: 100,
                    height: 50,
                    color: Colors.white,
                    child: DropdownButton<int>(
                      value: OniNum,
                      items: OniNumlist.map<DropdownMenuItem<int>>((int value){
                        return DropdownMenuItem<int>(
                            value: value,
                            child:Text('$value')
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState((){
                          OniNum=value!;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10,bottom: 5),
                    width: MediaQuery.of(context).size.width-120,
                    height: 50,
                    child: const Text(
                      '制限時間(分)',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: 100,
                    height: 50,
                    color: Colors.white,
                    child: DropdownButton<int>(
                      value: LimitTime,
                      items: LimitTimelist.map<DropdownMenuItem<int>>((int value){
                        return DropdownMenuItem<int>(
                            value: value,
                            child:Text('$value')
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState((){
                          LimitTime=value!;
                        });
                        },
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10,bottom: 5),
                    width: MediaQuery.of(context).size.width-120,
                    height: 50,
                    child: const Text(
                      '鬼の待機時間(秒)',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: 100,
                    height: 50,
                    color: Colors.white,
                    child: DropdownButton<int>(
                      value: StayTime,
                      items: StayTimelist.map<DropdownMenuItem<int>>((int value){
                        return DropdownMenuItem<int>(
                            value: value,
                            child:Text('$value')
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState((){
                          StayTime=value!;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              SizedBox(
                width: 180,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: (){},
                    child: const Text(
                        '詳細設定',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    )),
              ),
              const SizedBox(height: 15,),
              SizedBox(
                width: 210,
                height:75,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PlayingPage(),
                          ));
                    },
                    child: const Text(
                      '開始',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.black,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> members=['伊藤博文','卑弥呼','板垣退助','ウサイン・ボルト','グリシャ・イェーガー','太宰治','うちはマダラ','アノマロカリス','Windows11'];//参加者のリスト