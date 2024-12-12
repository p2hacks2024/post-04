import 'dart:convert';

import 'package:epsilon_app/model/history_model.dart';
import 'package:epsilon_app/state/storage_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'repository.g.dart';

@riverpod
SharedPreferences sharedPreferences(ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
SharedPreferencesRepository useSharedPreferencesRepository(ref) {
  return SharedPreferencesRepository(ref);
}

abstract class ISharedPreferencesRepository {
  Future<StorageState> get();
  Future<void> save(StorageState state);
  void clear();
}

class SharedPreferencesRepository implements ISharedPreferencesRepository {
  Ref ref;
  SharedPreferencesRepository(this.ref);


  @override
  Future<StorageState> get() async {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    //TODO: ここのnull関係改善する
    HistoryModel history = HistoryModel.fromJson(jsonDecode(prefs.getString('history') ?? ''));
    DateTime updated = DateTime.parse(prefs.getString('updated') ?? '');
    DateTime fetched = DateTime.parse(prefs.getString('fetched') ?? '');
    return StorageState(
      history: history,
      updated: updated,
      fetched: fetched
    );
  }

  @override
  Future<void> save(StorageState state) async {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('history', jsonEncode(state.history));
    await prefs.setString('updated', state.updated.toIso8601String());
    await prefs.setString('fetch', state.fetched.toIso8601String());
  }

  @override
  void clear() {
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    prefs.clear();
  }
}