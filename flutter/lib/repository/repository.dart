import 'dart:convert';

import 'package:epsilon_app/model/history_model.dart';
import 'package:epsilon_app/state/storage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'repository.g.dart';

@riverpod
SharedPreferences sharedPreferences(ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
SharedPreferencesRepository sharedPreferencesRepository(ref) {
  return SharedPreferencesRepository(ref);
}

abstract class ISharedPreferencesRepository {
  StorageState load();
  Future<void> save(StorageState state);
  void clearHistory();
}

class SharedPreferencesRepository implements ISharedPreferencesRepository {
  Ref ref;
  SharedPreferencesRepository(this.ref);

  @override
  StorageState load() {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    //TODO: ここのnull関係改善する
    List<HistoryModel> history = [];
    if (prefs.containsKey('history')) {
      prefs
          .getStringList('history')!
          .map((value) => {history.add(jsonDecode(value))});
    } else {
      debugPrint('history 404');
      prefs.setStringList('history', []);
    }
    if (!prefs.containsKey('updated')) {
      debugPrint('updated 404');
      prefs.setString('updated', '');
    }
    if (!prefs.containsKey('fetched')) {
      debugPrint('fetched 404');
      prefs.setString('fetched', '');
    }
    DateTime? updated;
    DateTime? fetched;
    if (prefs.getString('updated')!.isNotEmpty) {
      updated = DateTime.parse(prefs.getString('updated')!);
    }
    if (prefs.getString('fetched')!.isNotEmpty) {
      fetched = DateTime.parse(prefs.getString('fetched')!);
    }
    return StorageState(history: history, updated: updated, fetched: fetched);
  }

  @override
  Future<void> save(StorageState state) async {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    await prefs.setStringList(
        'history', state.history.map((value) => value.toString()).toList());
    final updatedText =
        (state.updated != null) ? state.updated!.toIso8601String() : '';
    final fetchedText =
        (state.fetched != null) ? state.fetched!.toIso8601String() : '';
    await prefs.setString('updated', updatedText);
    await prefs.setString('fetch', fetchedText);
  }

  @override
  void clearHistory() {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    prefs.setStringList('history', []);
  }
}
