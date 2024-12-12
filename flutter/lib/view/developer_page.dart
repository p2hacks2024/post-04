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
              child: const Text('usbSerial'),
              onPressed: () => context.push('/usb_serial_example'),
            ),
            TextButton(
              onPressed: () => context.push('/developer/storage_example'),
              child: const Text('ストレージデモ'),
            ),
          ],
        ),
      ),
    );
  }
}
