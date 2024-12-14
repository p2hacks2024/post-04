import 'package:design_sync/design_sync.dart';
import 'package:flutter/material.dart';

class PlayFlashPage extends StatelessWidget {
  final Color color;
  const PlayFlashPage({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(child: Text(
        'Flash!!!',
        style: TextStyle(
            fontSize: 64.adaptedFontSize,
            fontWeight: FontWeight.w800,
          ),
        )),
    );
  }
}
