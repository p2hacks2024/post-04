import 'package:design_sync/design_sync.dart';
import 'package:epsilon_app/component/app_bar.dart';
import 'package:epsilon_app/view_model/my_color_provider.dart';
import 'package:epsilon_app/view_model/play_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ConnectedPage extends ConsumerWidget {
  final Color? color;
  const ConnectedPage({super.key, this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(playViewModelProvider);
    var myColor = ref.watch(myColorProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint(timeStamp.toString());
      if (state.isPressed && !state.isSending) {
        context.pushReplacement('/play/charge');
      }
    });
    return Scaffold(
      appBar: (color == null) ? const MyAppBar(title: 'Flash') : const MyAppBar(title: 'Share'),
      body: Padding(
        padding: const EdgeInsets.only(top: 57.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/burning_man.svg'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 121.86.adaptedHeight),
                child: Container(
                  width: 256.adaptedWidth,
                  height: 58.adaptedHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.adaptedRadius),
                      boxShadow: <BoxShadow>[BoxShadow(color: myColor ?? Colors.white, blurStyle: BlurStyle.outer, blurRadius: 20)]),
                  child: TextButton(
                    onPressed: () async {
                      await ref.read(playViewModelProvider.notifier).start(color: color);
                    },
                    child: Text('Ready',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.adaptedFontSize,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
