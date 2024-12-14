import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_color_provider.g.dart';

@riverpod
class MyColor extends _$MyColor {
  @override
  Color build() {
    return Colors.green;
  }
}
