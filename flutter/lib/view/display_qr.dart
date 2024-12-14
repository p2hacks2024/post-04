import 'package:epsilon_app/repository/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DisplayQr extends ConsumerWidget {
  const DisplayQr({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRコード表示'),
      ),
      body: QrImageView(
        data: ref.watch(storageManagerProvider).history!.last.colorCode,
      ),
    );
  }
}