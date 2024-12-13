import 'package:epsilon_app/view_model/play_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class LoadQr extends ConsumerWidget {
  const LoadQr({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRコード読み込み'),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
        onDetect: (capture) {
          ref.read(playViewModelProvider.notifier).setColor(Color(int.parse(capture.barcodes[0].rawValue!, radix: 16)));
          debugPrint('LoadQr detected color: ${Color(int.parse(capture.barcodes[0].rawValue!, radix: 16))}');
          debugPrint('LoadQr after PlayState: ${ref.watch(playViewModelProvider)}');
        },
      ),
    );
  }
}
