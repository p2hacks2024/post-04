import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class LoadQr extends StatefulWidget {
  const LoadQr({super.key});
  @override
  State<LoadQr> createState() => _LoadQr();
}

class _LoadQr extends State<LoadQr> {
  String scannedData = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QRコード読み込み"),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
        onDetect: (capture) {
          setState(() {
            scannedData = capture.barcodes[0].rawValue!;
            debugPrint("scannedData: $scannedData");
          });
        },
      ),
    );
  }
}