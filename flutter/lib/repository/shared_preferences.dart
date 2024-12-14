import 'dart:convert';

import 'package:epsilon_app/model/history_model.dart';
import 'package:epsilon_app/state/storage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@riverpod
SharedPreferences sharedPreferences(ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
PrefsRepository prefsRepository(ref) {
  return PrefsRepository(ref);
}

abstract class IPrefsRepository {
  StorageState load();
  Future<void> save(StorageState state);
  void clear();
}

class PrefsRepository implements IPrefsRepository {
  Ref ref;
  PrefsRepository(this.ref);

  @override
  StorageState load() {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    List<HistoryModel> history = [];
    if (prefs.containsKey('history')) {
      history = prefs
          .getStringList('history')!
          .map((value) {
            return HistoryModel.fromJson(jsonDecode(value) as Map<String, dynamic>);
          }).toList();
    } else {
      prefs.setStringList('history', []);
    }
    return StorageState(history: history);
  }

  @override
  Future<void> save(StorageState state) async {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    await prefs.setStringList(
        'history', state.history!.map((value) => jsonEncode(value.toJson())).toList());
  }

  @override
  void clear() {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    prefs.setStringList('history', []);
  }
}
