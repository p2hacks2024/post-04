import 'package:flutter/material.dart';

class PlayFirePage extends StatelessWidget {
  final Color color;
  const PlayFirePage({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: const Center(child: Text("Flash!!")),
    );
  }
  
}
