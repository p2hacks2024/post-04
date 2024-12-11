import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DisplayQr extends StatelessWidget {
  final String qrData = '';
  const DisplayQr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRコード表示'),
      ),
      body: QrImageView(
        data: qrData,
      ),
    );
  }
}