import 'package:design_sync/design_sync.dart';
import 'package:epsilon_app/component/app_bar.dart';
import 'package:epsilon_app/view_model/play_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class LoadQr extends ConsumerWidget {
  const LoadQr({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(title: "Share"),
      body: Padding(
        padding: EdgeInsets.only(bottom: 264.adaptedHeight),
        child: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
          ),
          onDetect: (capture) {
            ref.read(playViewModelProvider.notifier).setColor(Color(int.parse(capture.barcodes[0].rawValue!, radix: 16)));

            debugPrint('LoadQr detected color: ${Color(int.parse(capture.barcodes[0].rawValue!, radix: 16))}');
            debugPrint('LoadQr after PlayState: ${ref.watch(playViewModelProvider)}');
            // context.push('/play/flash/${Color(int.parse(capture.barcodes[0].rawValue!, radix: 16)).value}');
            context.push('/play/connected/${Color(int.parse(capture.barcodes[0].rawValue!, radix: 16)).value}');
          },
        ),
      ),
    );
  }
}
