import 'dart:math';

import 'package:epsilon_app/component/app_bar.dart';
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
      appBar: const MyAppBar(title: 'Flash'),
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
        return _connectWidget(state.isConnected);
      }),
    );
  }

  Widget _connectWidget(bool isConnected) {
    const String waitingText =
        "Connect\nthe device's cable to\nyour smartphone";
    const String connectedText = 'Successfully\nconnected';
    const Widget waitingIcon = Icon(Icons.play_arrow_outlined, size: 100);
    const Widget connectedIcon = Icon(Icons.check_circle_outline_rounded,
        color: Color.fromARGB(255, 83, 255, 103), size: 70);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Transform.translate(
                  offset: const Offset(-165, 60),
                  child: Transform.scale(
                    scaleY: -1,
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: const Icon(Icons.cable, size: 242),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(200, 0),
                  child: const Icon(
                    Icons.stay_current_landscape,
                    size: 300,
                  ),
                ),
                (isConnected ? connectedIcon : waitingIcon),
              ],
            ),
            SizedBox(
              height: 102,
              child: Text(
                (isConnected ? connectedText : waitingText),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
