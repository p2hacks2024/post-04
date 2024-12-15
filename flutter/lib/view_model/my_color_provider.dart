import 'package:epsilon_app/repository/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_color_provider.g.dart';

@riverpod
class MyColor extends _$MyColor {
  @override
  Color? build() {
    final currentHistory = ref.watch(storageManagerProvider).history;
    if (currentHistory == null || currentHistory.isEmpty ) return null;
    final currentColors = ref.watch(storageManagerProvider).history!.map((value) => Color(int.parse(value.colorCode, radix: 16)));
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

    final aveColorElements = (aveR+aveG+aveB)/3;

    final diffFromAveR = aveR - aveColorElements;
    final diffFromAveG = aveG - aveColorElements;
    final diffFromAveB = aveB - aveColorElements;

    const magnification = 2.0;

    final finalR = diffFromAveR * magnification + aveColorElements;
    final finalG = diffFromAveG * magnification + aveColorElements;
    final finalB = diffFromAveB * magnification + aveColorElements;


    return Color.fromARGB(255, finalR.toInt(), finalG.toInt(), finalB.toInt());
  }
}
