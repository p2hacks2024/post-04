import 'dart:math';

import 'package:epsilon_app/repository/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_color_provider.g.dart';

@riverpod
class MyColor extends _$MyColor {
  @override
  Color? build() {
    final currentHistory = ref.watch(storageManagerProvider).history;
    if (currentHistory == null || currentHistory.isEmpty) return null;
    final currentColors = ref
        .watch(storageManagerProvider)
        .history!
        .map((value) => Color(int.parse(value.colorCode, radix: 16)));
    debugPrint('currentColors: $currentColors');
    double aveR = 0.0;
    double aveG = 0.0;
    double aveB = 0.0;
    for (Color color in currentColors) {
      aveR += color.red;
      aveG += color.green;
      aveB += color.blue;
    }

    aveR /= currentColors.length;
    aveG /= currentColors.length;
    aveB /= currentColors.length;

    final aveColorElements = (aveR + aveG + aveB) / 3;

    double distributedSumR = 0.0;
    double distributedSumG = 0.0;
    double distributedSumB = 0.0;

    for (Color color in currentColors) {
      distributedSumR += pow(aveR - color.red, 2);
      distributedSumG += pow(aveG - color.green, 2);
      distributedSumB += pow(aveB - color.blue, 2);
    }

    final diffFromAveR = aveR - aveColorElements;
    final diffFromAveG = aveG - aveColorElements;
    final diffFromAveB = aveB - aveColorElements;

    const magnification = 1.5;

    final finalR = diffFromAveR * magnification * distributedSumR + aveColorElements;
    final finalG = diffFromAveG * magnification * distributedSumG + aveColorElements;
    final finalB = diffFromAveB * magnification * distributedSumB + aveColorElements;

    return Color.fromARGB(255, finalR.toInt(), finalG.toInt(), finalB.toInt());
  }
}
