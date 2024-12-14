import 'package:carousel_slider/carousel_slider.dart';
import 'package:epsilon_app/view/widget/circular_color.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _current = 0;
  List<ColorCircle> colorList = [];

  @override
  void initState() {
    super.initState();
    if (colorList.isEmpty) {
      colorList.add(const ColorCircle());
    }
    colorList = colorList.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: AppBar(
            title: const Text(
              'History',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ),
        ),
      ),
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
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(
                            _current == ((colorList.length - 1) - entry.key)
                                ? 0.9
                                : 0.4)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
