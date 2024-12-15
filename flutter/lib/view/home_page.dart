import 'package:design_sync/design_sync.dart';
import 'package:epsilon_app/component/app_bar.dart';
import 'package:epsilon_app/view/widget/color_circle.dart';
import 'package:epsilon_app/view_model/my_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' show pi;

import 'package:go_router/go_router.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color = ref.watch(myColorProvider);
    return Scaffold(
      appBar: const MyAppBar(title: "My Color", hasLeading: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 82.adaptedHeight,
          ),
          ColorCircle(
            color: color,
          ),
          SizedBox(
            height: 116.adaptedHeight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // figmaだと，少し右にずらしてるけど，何も調整しない方が真ん中だ
              _homeIconButton(
                Icons.send_to_mobile,
                onPressed: () {
                  context.push('/qr');
                },
                color: color,
              ),
              const SizedBox(
                width: 32,
              ),
              Transform.rotate(
                angle: -pi,
                child: _homeIconButton(
                  Icons.tungsten,
                  onPressed: () {
                    context.push('/play/play/false');
                  },
                  color: color,
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              _homeIconButton(
                Icons.history,
                onPressed: () {
                  context.push('/history');
                },
                color: color,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _homeIconButton(IconData icon, {required void Function() onPressed, Color? color, EdgeInsetsGeometry? padding}) {
    return IconButton(
      onPressed: onPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: Container(
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(40)), boxShadow: [
          BoxShadow(
            color: color ?? Colors.white,
            blurStyle: BlurStyle.outer,
            blurRadius: 20,
          ),
        ]),
        height: 80,
        width: 80,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0),
          child: Icon(
            size: 45,
            icon,
          ),
        ),
      ),
    );
  }
}
