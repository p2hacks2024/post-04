import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DisplayQR extends StatelessWidget {
  const DisplayQR({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QRコード表示"),
      ),
      body: QrImageView(
        data: "HelloWorld",
      ),
    );
  }
}