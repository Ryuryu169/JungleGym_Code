import 'package:flutter/material.dart';

class OnigokkoPage extends StatelessWidget {
  const OnigokkoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("鬼ごっこ"),
      ),
      body: Column(),
    );
  }
}