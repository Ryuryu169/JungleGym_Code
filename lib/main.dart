import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jungle_gym/src/Login/LoginPage.dart';

import 'src/Chats/firebase_options.dart';
import 'src/Chats/mainDub.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp1());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}