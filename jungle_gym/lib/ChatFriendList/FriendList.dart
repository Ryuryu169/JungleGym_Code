import 'package:flutter/material.dart';
import 'ChatScreen.dart';

const Color BackGroundColor = Colors.white;
const Color? FriendIconBackColor = Color(0xFFE0E0E0);
const Color? FriendIconColor = Color(0xFF424242);

class FriendList extends StatefulWidget {
  @override
  _FriendList createState() => _FriendList();
}


class _FriendList extends State<FriendList> {
  final List<String> names = <String>['Taro','Kyoko'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:BackGroundColor,
      appBar: AppBar(
        title: Text('フレンド一覧',style: TextStyle(color: AppBarTextColor),),
        centerTitle: true,
        backgroundColor: AppBarBackColor,
        elevation: 2,
        actions: <Widget>[
          IconButton(
            icon: Icon(null),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Expanded(
            child:InkWell(
              onTap: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ChatScreen())
                );
              },
              child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: names.length,
              itemBuilder: (BuildContext context, int index) => Card(
                  elevation: 0,
                  margin: EdgeInsetsDirectional.only(top: 1,start: 10,end: 10),
                child: ListTile(
                  leading: ClipOval(
                    child: Container(
                      color: FriendIconBackColor,
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.face,
                        color: FriendIconColor,
                      ),
                    ),
                  ),
                  title: Text('Entry ${names[index]}'),
                  trailing: Icon(Icons.more_vert),
                )),
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
            ),
          ),
          SizedBox(height: 50,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()  {
          //処理
        },
      ),
    );
  }
}


/*
class AddFriend extends StatefulWidget {
  @override
  _AddFriend createState() => _AddFriend();
}



class _AddFriend extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:BackGroundColor,
      appBar: AppBar(
        title: Text('友達追加',style: TextStyle(color: AppBarTextColor),),
        centerTitle: true,
        backgroundColor: AppBarBackColor,
        elevation: 2,
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: AppBarIconColor),
          onPressed: () async {
            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context)=>
                  FriendList()),
            );
          },
          ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    //処理
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    //処理
                  });
                },
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  child: Text('登録'),
                  onPressed: () async {
                    //処理
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
