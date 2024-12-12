import 'package:epsilon_app/service/foreground_serial_service.dart';
import 'package:epsilon_app/state/serial_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play'),
      ),
      body: Consumer(builder: (context, ref, _) {
        SerialServiceState state = ref.watch(serialServiceProvider);
        if (state.isConnected) {
          WidgetsBinding.instance.addPostFrameCallback((duration) async {
            await Future.delayed(const Duration(seconds: 1));
            if (context.mounted) {
              context.pushReplacement('/play/connected');
            }
          });
        }
        if (state.isConnected) {
          return const Center(
            child: Text('Connecting!!'),
          );
        }
        return Center(
          child: Text(
            '${state.isConnected}',
            style: const TextStyle(fontSize: 24),
          ),
        );
      }),
    );
  }
}
