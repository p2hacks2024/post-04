import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ColorCircle extends StatefulWidget {
  final Color? color;

  const ColorCircle({super.key, this.color});

  @override
  State<ColorCircle> createState() => _ColorCircleState();

  Future<void> toggleFront() async {
    await _ColorCircleState().toggleFront();
  }
}

class _ColorCircleState extends State<ColorCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isFront = true;
  bool _isAnimating = false;
  bool _isReversed = false;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: pi).animate(_animationController)
      ..addListener(() {
        if ((0.6 > _animationController.value &&
                _animationController.value > 0.5) &&
            !_isReversed) {
          _isFront = !_isFront;
          _isReversed = true;
        } else if (_animationController.value == 1 ||
            _animationController.value == 0) {
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

  void _toggle() {
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

  Future<void> toggleFront() async {
    toFront() {
      if (_isFront) {
      } else {
        _toggle();
      }
    }

    if (!_isAnimating) {
      toFront();
    } else {
      while (_isAnimating) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      toFront();
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
              color: _isFront
                  ? (widget.color ?? const Color.fromARGB(255, 161, 161, 161))
                  : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(280)),
              border: Border.all(color: Colors.black, width: 12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                  child: _isFront
                      ? (widget.color == null
                          ? const Text("No Color",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600))
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.color == null
                                    ? "No Color"
                                    : '#${widget.color!.value.toRadixString(16).toUpperCase()}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        )),
            ),
          ),
        ),
      ),
      onPressed: () {
        if (widget.color == null) return;
        _toggle();
      },
    );
  }
}
