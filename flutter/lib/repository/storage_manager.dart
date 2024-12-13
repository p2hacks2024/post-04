import 'package:epsilon_app/model/history_model.dart';
import 'package:epsilon_app/repository/shared_preferences.dart';
import 'package:epsilon_app/state/storage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_manager.g.dart';

@riverpod
class StorageManager extends _$StorageManager {
  @override
  StorageState build() {
    return ref.read(prefsRepositoryProvider).load();
  }

  void addColor({required Color inputColor}) {
    List<HistoryModel> historyList = [...state.history ?? []];
    historyList.add(
      HistoryModel(
          colorCode: inputColor.value.toRadixString(16),
          created: DateTime.now(),
        ),
    );
    state = state.copyWith(
      history: historyList,
      updated: DateTime.now(),
      fetched: DateTime.now()
    );
  }

  Future<void> save() async {
    ref.read(prefsRepositoryProvider).save(state);
  }

  void deleteHistory() {
    state = state.copyWith(
      history: [],
      updated: DateTime.now()
    );
  }
}
