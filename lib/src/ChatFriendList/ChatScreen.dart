import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'FriendList.dart';
const Color PostTextColor = Colors.green;
const Color PostFrameColor = Colors.white;
const Color PostBackColor = Colors.white70;
const Color AppBarIconColor = Colors.blueAccent;
const Color AppBarTextColor = Colors.black87;
const Color AppBarBackColor = Colors.white;
const Color MessageBackColor = Colors.black12;



class ChatScreen extends StatefulWidget {
  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> messages = <String>['無駄無駄無駄無駄無駄無駄','uryyyyyyyyyyyyyyyy'];
    final messageTextController = TextEditingController();
    String messageText = '';
    String name = '死にかけのポメラニアン';
    bool isMyturn = true;

    return Scaffold(
      backgroundColor:BackGroundColor,
      appBar: AppBar(
        title: Text(name,style: TextStyle(color: AppBarTextColor),),
        centerTitle: true,
        backgroundColor: AppBarBackColor,
        elevation: 2,
        leading:IconButton(
            icon: Icon(Icons.arrow_back_ios_new,size: 30,),
            color: AppBarIconColor,
            onPressed: () async {
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=>
                  FriendList()),
              );
            },
          ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Bubble(
                  margin: BubbleEdges.all(12),
                  color: MessageBackColor,
                  nip: isMyturn
                      ?BubbleNip.leftBottom
                      :BubbleNip.rightTop,
                  alignment: isMyturn
                      ?Alignment.topLeft
                      :Alignment.topRight,
                  elevation: 0,
                  radius: Radius.circular(20),
                  child: Text(
                    messages[index],
                    style: TextStyle(fontSize: 19),
                  ),
                );},
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: 40,end: 10,),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: '投稿メッセージ',
                  hintStyle: const TextStyle(fontSize: 12, color: PostTextColor),
                  fillColor:PostBackColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      width: 2,
                      color: PostFrameColor,
                    ),
                  ),
                  suffixIcon:IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      //処理
                    }, )
              ),
              keyboardType: TextInputType.multiline,
              controller: messageTextController,
              onChanged: (value) {
                messageText = value;
              },
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
