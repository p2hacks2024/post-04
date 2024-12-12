import 'package:flutter/material.dart';

class PlayFlashPage extends StatelessWidget {
  final Color color;
  const PlayFlashPage({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash'),
      ),
      backgroundColor: color,
      body: const Center(child: Text('Flash!!')),
    );
  }
}
