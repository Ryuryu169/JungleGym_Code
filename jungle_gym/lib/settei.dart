import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hatch Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView(
          children: [
            _menuItem("back to home", Icon(Icons.arrow_back)),
            _menuItem("Volume", Icon(Icons.volume_up)),
            _menuItem("image quality", Icon(Icons.high_quality)),
            _menuItem("User image change", Icon(Icons.perm_media)),
            _menuItem("Username change", Icon(Icons.badge)),
            _menuItem("access rights", Icon(Icons.settings)),
            _menuItem("feedback", Icon(Icons.report_problem)),
            Container(
              child:
            )
          ]
      ),
    );
  }

  Widget _menuItem(String title, Icon icon) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.0
          ),
        ),
        onTap: () {

        }, // タップ
      ),
    );
  }