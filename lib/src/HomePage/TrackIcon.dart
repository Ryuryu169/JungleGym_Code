import 'package:flutter/material.dart';

class TrackIcon extends StatelessWidget {
  final Color colorValue;

  const TrackIcon({super.key, required this.colorValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Image.asset(
        "assets/icons/wolf.png",
        height: 30,
        color: colorValue,
      ),
    );
  }
}