import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => context.push('/developer/storage_example'),
              child: const Text('ストレージ実験'),
            ),
            TextButton(
              onPressed: () => context.push('/developer/display_qr'),
              child: const Text('QRコード表示'),
            ),
            TextButton(
              onPressed: () => context.push('/developer/load_qr'),
              child: const Text('QRコード読取'),
            ),
          ],
        ),
      ),
    );
  }
}
