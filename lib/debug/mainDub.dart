import 'package:flutter/material.dart';

import 'rooms.dart';

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Firebase Chat',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const RoomsPage(),
  );
}