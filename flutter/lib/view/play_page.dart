import 'package:epsilon_app/service/foreground_serial_service.dart';
import 'package:epsilon_app/state/serial_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          SerialServiceState state = ref.watch(serialServiceProvider);
          return Center(
            child: Text(
              "${state.isConnected}",
              style: TextStyle(fontSize: 24),
            ),
          );
        }
      ),
  );
  }
}
