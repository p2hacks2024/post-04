import 'dart:convert';

import 'package:epsilon_app/model/history_model.dart';
import 'package:epsilon_app/repository/repository.dart';
import 'package:epsilon_app/state/storage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'storage_manager.g.dart';

@riverpod
class StorageManager extends _$StorageManager {
  final String history = 'history';
  final String color = 'color';
  final String created = 'created';
  final String updated = 'updated';

  @override
  StorageState build() {
    return ref.read(sharedPreferencesRepositoryProvider).load();
  }

  void addColor({required Color inputColor}) {
    debugPrint('state(addData): $state');
    List<HistoryModel> historyList = [...state.history];
    historyList.add(
      HistoryModel(
          colorCode: '#${inputColor.value.toRadixString(16).substring(2)}',
          created: DateTime.now(),
        ),
    );
    state = state.copyWith(
      history: historyList,
      updated: DateTime.now(),
    );
    debugPrint('after state(addData): $state');
  }

  //historyIndexに-1を入れると、最新のデータを取得できる
  dynamic getData(
      {required String key, int? historyIndex, String? historyKey}) {
        debugPrint('state(getData): $state');
    if (key == history && historyIndex != null) {
      if (historyIndex == -1) {
        historyIndex = state.history.length - 1;
      }
      return (state.history[historyIndex]);
    }
    //TODO: 改良する
    switch (key) {
      case 'updated': 
        return state.updated;
      case 'fetched':
        return state.fetched;
    }
  }

  String getAllDataString() {
    debugPrint('state(getAllDataString): $state');
    String text = 'history: [';
    for (int i=0; i<state.history.length; i++) {
      HistoryModel entry = state.history[i];
      text += '\n  {';
      text += '\n   color: ${entry.colorCode},\n';
      final createdText = entry.created.toIso8601String();
      text += '   created: $createdText\n';
      text += '  }';
      if (i==state.history.length-1) break;
      text += ',';
    }
    // text = text.substring(0, text.length-1);
    text += '\n],';
    text += '\nupdated: ${state.updated},';
    text += '\nfetched: ${state.fetched}';
    debugPrint('storageText: $text');
    return text;
  }

  Future<void> save() async {
    debugPrint('state(save): $state');
    ref.read(sharedPreferencesRepositoryProvider).save(state);
  }

  void deleteHistory() {
    debugPrint('state(deleteAllStorage): $state');
    state = state.copyWith(
      history: [],
      updated: DateTime.now()
    );
  }
}
