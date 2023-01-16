import 'package:flutter/material.dart';

import 'FirstPage.dart';

class FirstJinrou extends StatefulWidget {
  const FirstJinrou({super.key});

  @override
  State<FirstJinrou> createState() => _FirstJinrouState();
}

class _FirstJinrouState extends State<FirstJinrou>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FirstPage(
      name: "Jinrou",
      anime: _controller,
      controller: _textEditingController,
      rules: const {},
    );
  }
}
