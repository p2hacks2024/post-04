// import 'package:design_sync/design_sync.dart';
// import 'package:flutter/material.dart';

// class PlayFlashPage extends StatefulWidget {
//   final Color color;
//   const PlayFlashPage({super.key, required this.color});

//   @override
//   State<PlayFlashPage> createState() => _PlayFlashPageState();
// }

// class _PlayFlashPageState extends State<PlayFlashPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//     _animationController.forward();
//     _animation = Tween(begin: 1.0, end: 915.0).animate(_animationController)
//       ..addListener(() {
//         setState(() {
//           debugPrint('value1: ${_animation.value}');
//         });
//       });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: widget.color,
//       body: Center(
//         child: Container(
//           width: _animation.value,
//           height: _animation.value,
//           decoration: BoxDecoration(
//               color: widget.color,
//               borderRadius: BorderRadius.all(Radius.circular(_animation.value))),
//           child: Center(
//               child: Text(
//             'Flash!!!',
//             style: TextStyle(
//               fontSize: 64.adaptedFontSize,
//               fontWeight: FontWeight.w800,
//             ),
//           )),
//         ),
//       ),
//     );
//   }
// }

import 'package:design_sync/design_sync.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlayFlashPage extends StatefulWidget {
  final Color color;
  const PlayFlashPage({super.key, required this.color});

  @override
  State<PlayFlashPage> createState() => _PlayFlashPageState();
}

class _PlayFlashPageState extends State<PlayFlashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 3));
      if (context.mounted) {
        debugPrint("result: ${widget.color.value}");
        context.go('/play/result/${widget.color.value}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: Center(
          child: Text(
        'Flash!!!',
        style: TextStyle(
          fontSize: 64.adaptedFontSize,
          fontWeight: FontWeight.w800,
        ),
      )),
    );
  }
}
