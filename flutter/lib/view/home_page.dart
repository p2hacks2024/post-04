import 'package:epsilon_app/view/widget/color_circle.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final Color? color = Color(0xFF53FFFF);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 85, bottom: 138),
              child: Text(
                "My Color",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          ColorCircle(
            color: color,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 140)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // figmaだと，少し右にずらしてるけど，何も調整しない方が真ん中だ
              _homeIconButton(
                Icons.send_to_mobile,
                onPressed: () {},
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
                    context.push('/play');
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
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            //border: Border.all(color: Colors.white, width: 6),
            boxShadow: [
              BoxShadow(
                //color: Colors.white, blurStyle: BlurStyle.outer, blurRadius: 20,
                color: color ?? const Color.fromARGB(255, 161, 161, 161),
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
