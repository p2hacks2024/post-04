import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextButton(
          child: Text("usbSerial"),
          onPressed: () => context.push("/usb_serial_example"),
        )
      ],
    ));
  }
}
