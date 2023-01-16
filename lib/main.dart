import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jungle_gym/src/HomePage/Homepage.dart';
import 'package:jungle_gym/src/Login/LoginPage.dart';

import 'src/Chats/firebaseOptions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  Widget myapp = Container();

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: myapp,
    );
  }

  void initializeFlutterFire() async {
    User? user;
    try {
      await Firebase.initializeApp();
      user = FirebaseAuth.instance.currentUser;
      if (user?.uid == null) {
        if (kDebugMode) {
          print(user?.uid);
        }
        if (!mounted) return;
        setState((){myapp = const LoginPage();});
      } else {
        if (!mounted) return;
        setState((){myapp = const HomePage();});
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
