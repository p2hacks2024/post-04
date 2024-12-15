import 'package:design_sync/design_sync.dart';
import 'package:epsilon_app/component/app_bar.dart';
import 'package:epsilon_app/repository/storage_manager.dart';
import 'package:epsilon_app/view_model/my_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DisplayQr extends ConsumerWidget {
  const DisplayQr({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(title: "Share"),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(56.adaptedWidth),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.adaptedWidth)),
                  border: Border.all(color: Colors.white, width: 30.adaptedWidth)),
              child: QrImageView(
                data: ref.watch(myColorProvider).value.toRadixString(16),
              ),
            ),
          ),
          SizedBox(
            height: 90.adaptedHeight,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                //border: Border.all(color: Colors.white, width: 6),
                boxShadow: [
                  BoxShadow(
                    //color: Colors.white, blurStyle: BlurStyle.outer, blurRadius: 20,
                    color: ref.watch(myColorProvider) ?? Colors.white,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 20,
                  ),
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.adaptedWidth, vertical: 10.adaptedHeight),
              child: TextButton(
                child:
                    Text("Receive Color", style: TextStyle(color: Colors.white, fontSize: 18.adaptedFontSize, fontWeight: FontWeight.w600)),
                onPressed: () {
                  context.push('/play/play/true');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
