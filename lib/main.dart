import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'Setting.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DebugPage(),
    );
  }
}

class DebugPage extends StatelessWidget{
  const DebugPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage(),
                    ));},
              child: const Text('ログインページ'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingPage(),
                    ));},
              child: const Text('セッティングページ'),
            )
          ],
        ),
      ),
    );
  }
  
}