import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontFamily: 'RussoOne',
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-50,
        color: Colors.black,
        child: ListView(
          children: [
            InkWell(
              onTap: (){},
              child: _Itemstheme('設定項目',const Icon(Icons.settings,color: Colors.white,)),
            ),//項目を増やすときはこのInkWellを複製
          ],
        ),
      ),
    );
  }
  Widget _Itemstheme(String title, Icon icon){
    return Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0, color: Colors.white))
        ),
        child:ListTile(
          leading: icon,
          tileColor: Colors.black,
          title: Text(
            title,
            style: const TextStyle(
              color:Colors.white,
              fontSize: 18.0,
              fontFamily: 'RussoOne',
            ),
          ),
        )
    );
  }
}