import 'package:carousel_slider/carousel_slider.dart';
import 'package:epsilon_app/component/app_bar.dart';
import 'package:epsilon_app/repository/shared_preferences.dart';
import 'package:epsilon_app/repository/storage_manager.dart';
import 'package:epsilon_app/view/widget/color_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  int _current = 0;
  List<ColorCircle> colorList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var history = ref.watch(storageManagerProvider).history;
    if (history == null) {
      colorList = [];
      debugPrint("nullです");
    } else {
      history.forEach((value) => print(value.colorCode));
      debugPrint(history.length.toString());
      //colorList = history.map((e) => ColorCircle(color: Color())).toList();
    }
    debugPrint("aiueo");

    if (colorList.isEmpty) {
      colorList.add(const ColorCircle());
    }
    colorList = colorList.reversed.toList();
    return Scaffold(
      appBar: const MyAppBar(title: "History"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: CarouselSlider(
              items: colorList,
              options: CarouselOptions(
                  reverse: true,
                  height: 380,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  onPageChanged: (index, reason) async {
                    colorList[_current].toggleFront();
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: colorList.asMap().entries.map((entry) {
              return Container(
                width: 15.0,
                height: 15.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                        .withOpacity(_current == ((colorList.length - 1) - entry.key) ? 0.9 : 0.4)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
