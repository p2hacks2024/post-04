import 'package:epsilon_app/model/history_model.dart';
import 'package:epsilon_app/repository/repository.dart';
import 'package:epsilon_app/state/storage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_manager.g.dart';

@riverpod
class StorageManager extends _$StorageManager {
  final String history = 'history';
  final String color = 'color';
  final String created = 'created';
  final String updated = 'updated';

  @override
  StorageState build() {
    debugPrint('1: StorageManager.build() prefs: ${ref.read(sharedPreferencesProvider).getStringList('history')}');
    // debugPrint('StorageManager.build() state: $state');
    return ref.read(sharedPreferencesRepositoryProvider).load();
  }

  void addColor({required Color inputColor}) {
    List<HistoryModel> historyList = [...state.history ?? []];
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
  }

  //historyIndexに-1を入れると、最新のデータを取得できる
  dynamic getData(
      {required String key, int? historyIndex, String? historyKey}) {
    if (key == history && historyIndex != null) {
      if (historyIndex == -1) {
        historyIndex = state.history!.length - 1;
      }
      return (state.history![historyIndex]);
    }
    //TODO: 改良する
    switch (key) {
      case 'updated': 
        return state.updated;
      case 'fetched':
        return state.fetched;
    }
  }

  //unused
  String getAllDataString() {
    String text = 'history: [';
    for (int i=0; i<state.history!.length; i++) {
      HistoryModel entry = state.history![i];
      text += '\n  {';
      text += '\n   color: ${entry.colorCode},\n';
      final createdText = entry.created.toIso8601String();
      text += '   created: $createdText\n';
      text += '  }';
      if (i==state.history!.length-1) break;
      text += ',';
    }
    // text = text.substring(0, text.length-1);
    text += '\n],';
    text += '\nupdated: ${state.updated},';
    text += '\nfetched: ${state.fetched}';
    return text;
  }

  Future<void> save() async {
    debugPrint('4: StorageManager.save() state: ${state.history}');
    ref.read(sharedPreferencesRepositoryProvider).save(state);
  }

  void deleteHistory() {
    state = state.copyWith(
      history: [],
      updated: DateTime.now()
    );
  }
}
