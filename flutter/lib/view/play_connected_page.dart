import 'package:design_sync/design_sync.dart';
import 'package:epsilon_app/component/app_bar.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (state.isPressed && !state.isSending) {
        context.pushReplacement('/play/charge');
      }
    });
    return Scaffold(
      appBar: const MyAppBar(title: 'Flash'),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.adaptedRadius), boxShadow: const <BoxShadow>[
                    BoxShadow(color: Color.fromARGB(200, 83, 255, 255), blurStyle: BlurStyle.outer, blurRadius: 20)
                  ]),
                  child: TextButton(
                    onPressed: () async {
                      await ref.read(playViewModelProvider.notifier).start();
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
