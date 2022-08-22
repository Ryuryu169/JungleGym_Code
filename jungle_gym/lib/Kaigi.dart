import 'package:flutter/material.dart';

class KaigiPage extends StatefulWidget {
  const KaigiPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<KaigiPage> createState() => _KaigiPageState();
}

class _KaigiPageState extends State<KaigiPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          title: Text(
            "待機画面",
            style: TextStyle(
              fontFamily: 'lanove',
              fontSize: 24,
            ),
          ),
        ),
        body: Container(
/*            decoration: BoxDecoration(
              // 背景画像
              image: DecorationImage(
                image: AssetImage('assets/images/dyce.png'),
                fit: BoxFit.fill,
              ),
            ),*/
            decoration: BoxDecoration(color: Colors.white54),
            child: Column(
                children: [
                  Container(
                      width: 500,
                      height: 50,
                      padding: const EdgeInsets.only(left: 60,top: 10),
                      child:Row(
                        children: [
                          ElevatedButton(
                            child: const Text(
                              "友人を招待する",
                            ),
                            onPressed: (){

                            },
                          ),
                          SizedBox(width: 30,),
                          ElevatedButton(
                            child: const Text(
                              "TCを表示する",
                            ),
                            onPressed: (){
                              /*参加してるメンバーのテキストチャットへ*/
                            },
                          ),
                          SizedBox(width: 30,),
                          /*ElevatedButton(
                            child: const Text(
                              "VCをオンにする",
                            ),

                            onPressed: (){
                              /*参加してるメンバーでの通話開始*/
                            },
                          ),*/
                        ],
                      )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30,top: 20),
                    child: Row(
                      children: const [
                        Icon(Icons.account_circle,///それぞれのアカウントの画像かアイコンを参加者が来るたびに配置
                          color: Colors.black87,
                          size: 45,),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text("ゲームの名前",style: TextStyle(fontSize: 28,fontFamily: 'lanove'),),
                      Container(
                        child: Padding(padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        ),

                      ),
                      ElevatedButton(
                          onPressed: (){
                            showDialog(context: context, builder: (_)=> SimpleDialog(
                              title: Text("遊び方",style: TextStyle(fontSize: 24,fontFamily: 'lanove',decoration: TextDecoration.underline),),
                              children: [
                                ///説明つらつら
                              ],
                            ));
                          },
                          child: const Text("遊び方",style: TextStyle(fontSize: 24,fontFamily: 'lanove',),)),
                      Container(
                        child: Padding(padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        ),

                      ),
                      ///もしプレイヤーがオーナーなら
                      ElevatedButton(
                          onPressed: (){
                            ///ゲームの設定画面に移動、ゲーム内容が決定後実装
                          },
                          child: const Text("ゲーム設定",style: TextStyle(fontSize: 24,fontFamily: 'lanove'),)),
                      Container(
                        child: Padding(padding: EdgeInsets.only(
                          top: 10,
                          bottom: 150,
                        ),
                        ),

                      ),
                      ElevatedButton(
                          onPressed: (){
                            ///参加者全員が完了なら次の画面に遷移
                          },
                          child: const Text("準備完了",style: TextStyle(fontSize: 24,fontFamily: 'lanove'),)),
                    ],
                  ),


                ]
            )
        )
    );
  }
}