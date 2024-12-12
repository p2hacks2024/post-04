import 'package:epsilon_app/service/foreground_serial_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connected'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      const Text("人"),
      Consumer(
        builder: (context, ref, _) {
          return ElevatedButton(
            onPressed: () async {
              await 
                  ref.read(serialServiceProvider.notifier).start();
            }, child: const Text("SET"));
        }
      )
        ],
      ),
    );
  }

}
