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
  void clearHistory();
}

class PrefsRepository implements IPrefsRepository {
  Ref ref;
  PrefsRepository(this.ref);

  @override
  StorageState load() {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    List<HistoryModel> history = [];
    if (prefs.containsKey('history')) {
      if (ref.read(sharedPreferencesProvider).getStringList('history')!.isNotEmpty) {
        debugPrint('${HistoryModel.fromJson(jsonDecode(ref.read(sharedPreferencesProvider).getStringList('history')![0]) as Map<String, dynamic>)}');
      }
      history = prefs
          .getStringList('history')!
          .map((value) {
            return HistoryModel.fromJson(jsonDecode(value) as Map<String, dynamic>);
          }).toList();
    } else {
      prefs.setStringList('history', []);
    }
    if (!prefs.containsKey('updated')) {
      prefs.setString('updated', '');
    }
    if (!prefs.containsKey('fetched')) {
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
        'history', state.history!.map((value) => jsonEncode(value.toJson())).toList());
    final updatedText =
        (state.updated != null) ? state.updated!.toIso8601String() : '';
    final fetchedText =
        (state.fetched != null) ? state.fetched!.toIso8601String() : '';
    await prefs.setString('updated', updatedText);
    await prefs.setString('fetched', fetchedText);
  }

  @override
  void clearHistory() {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    prefs.setStringList('history', []);
  }
}
