import 'package:flutter/material.dart';

import 'FirstPage.dart';

class FirstTag extends StatefulWidget {
  const FirstTag({super.key});

  @override
  State<FirstTag> createState() => _FirstTagState();
}

class _FirstTagState extends State<FirstTag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FirstPage(
      name: "Onigo",
      controller: _textController,
      anime: _controller,
      rules: const {},
    );
  }
}
