import 'package:design_sync/design_sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/home');
            });
            return const SizedBox.shrink();
          } else {
            return Scaffold(
                body: Center(
              child: Image.asset(
                'assets/app_icon.png',
                scale: 3.5,
              ),
            ));
          }
        });
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
