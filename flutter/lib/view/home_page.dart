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
                onPressed: () {},
                color: color,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _homeIconButton(IconData icon,
      {required void Function() onPressed,
      Color? color,
      EdgeInsetsGeometry? padding}) {
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

class ColorCircle extends StatefulWidget {
  final Color? color;

  const ColorCircle({super.key, this.color});

  @override
  State<ColorCircle> createState() => _ColorCircleState();
}

class _ColorCircleState extends State<ColorCircle> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isFront = true;
  bool _isAnimating = false;
  bool _isReversed = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: pi).animate(_animationController)
      ..addListener(() {
        if ((0.6 > _animationController.value && _animationController.value > 0.5) && !_isReversed) {
          _isFront = !_isFront;
          _isReversed = true;
        } else if (_animationController.value == 1 || _animationController.value == 0) {
          _isAnimating = false;
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFront() {
    if (!_isAnimating) {
      setState(() {
        _isAnimating = true;
        _isReversed = false;
      });
      if (_isFront) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: Container(
        height: 304,
        width: 304,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(280)),
            boxShadow: widget.color == null
                ? []
                : [
                    BoxShadow(
                      color: widget.color!,
                      blurStyle: BlurStyle.solid,
                      blurRadius: 40,
                    ),
                  ]),
        child: Transform(
          transform: Matrix4.rotationY(_animation.value),
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: _isFront ? (widget.color ?? const Color.fromARGB(255, 161, 161, 161)) : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(280)),
              border: Border.all(color: Colors.black, width: 12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                  child: _isFront
                      ? (widget.color == null
                          ? const Text("No Color", style: TextStyle(color: Colors.black, fontSize: 20))
                          : const SizedBox.shrink())
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(pi),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: widget.color,
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.color == null ? "No Color" : '#${widget.color!.value.toRadixString(16).toUpperCase()}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        )),
            ),
          ),
        ),
      ),
      onPressed: () {
        _toggleFront();
      },
    );
  }
}
