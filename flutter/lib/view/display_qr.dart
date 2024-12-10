import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DisplayQr extends StatelessWidget {
  const DisplayQr({super.key, required this.qrData});
  final String qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QRコード表示"),
      ),
      body: QrImageView(
        data: qrData,
      ),
    );
  }
}