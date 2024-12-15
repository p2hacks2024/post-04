import 'package:design_sync/design_sync.dart';
import 'package:epsilon_app/component/app_bar.dart';
import 'package:epsilon_app/view/widget/color_circle.dart';
import 'package:epsilon_app/view_model/my_color_provider.dart';
import 'package:epsilon_app/view_model/play_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Result extends StatelessWidget {
  final Color color;
  const Result({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: "Result", hasLeading: false),
        body: Center(
          child: Column(
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
              Consumer(builder: (context, ref, _) {
                var mycolor = ref.watch(myColorProvider);
                return Container(
                  width: 256.adaptedWidth,
                  height: 58.adaptedHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.adaptedRadius),
                      boxShadow: (mycolor != null) ? [BoxShadow(color: mycolor, blurStyle: BlurStyle.outer, blurRadius: 20)] : []),
                  child: TextButton(
                    onPressed: () async {
                      context.go('/home');
                    },
                    child: Text('My Color',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.adaptedFontSize,
                        )),
                  ),
                );
              }),
            ],
          ),
        ));
  }
}
