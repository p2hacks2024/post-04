import 'package:flutter/material.dart';
import 'dart:math' show pi;

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
              _homeIconButton(Icons.send_to_mobile, color: color),
              const SizedBox(
                width: 32,
              ),
              Transform.rotate(
                angle: -pi,
                child: _homeIconButton(Icons.tungsten, color: color),
              ),
              const SizedBox(
                width: 32,
              ),
              _homeIconButton(Icons.history, color: color),
            ],
          )
        ],
      ),
    );
  }

  Widget _homeIconButton(IconData icon, {Color? color, EdgeInsetsGeometry? padding}) {
    return IconButton(
      onPressed: () {},
      highlightColor: null,
      splashColor: null,
      hoverColor: null,
      icon: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
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

class ColorCircle extends StatefulWidget {
  final Color? color;

  const ColorCircle({super.key, this.color});

  @override
  State<ColorCircle> createState() => _ColorCircleState();
}

class _ColorCircleState extends State<ColorCircle> {
  @override
  Widget build(BuildContext context) {
    return Transform(
      //transform: Matrix4.identity()..rotateY(pi),
      transform: Matrix4.identity()..rotateY(0.0),
      child: Container(
        height: 304,
        width: 304,
        decoration: BoxDecoration(
            color: widget.color ?? const Color.fromARGB(255, 161, 161, 161),
            borderRadius: const BorderRadius.all(Radius.circular(280)),
            border: Border.all(color: Colors.black, width: 12),
            boxShadow: widget.color == null
                ? []
                : [
                    BoxShadow(
                      color: widget.color!,
                      blurStyle: BlurStyle.solid,
                      blurRadius: 40,
                    ),
                  ]),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: widget.color == null
                  ? const Text("No Color", style: TextStyle(color: Colors.black, fontSize: 20))
                  : const SizedBox.shrink()),
        ),
      ),
    );
  }
}
