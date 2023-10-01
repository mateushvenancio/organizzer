import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:shared_preferences/shared_preferences.dart';

// typedef Items = List<Map<String, dynamic>>;
// typedef Item = Map<String, dynamic>;
// typedef Where = bool Function(T);

abstract class PreferencesAbstraction<T> {
  final _completer = Completer();
  late final SharedPreferences _prefs;

  String get key;
  T fromMap(Map<String, dynamic> value);
  Map<String, dynamic> toMap(T value);

  PreferencesAbstraction() {
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      _completer.complete();
    });
  }

  Future<List<T>> getItems() async {
    await _completer.future;
    final result = jsonDecode(_prefs.getString(key) ?? '[]');
    return [...result].map((e) => fromMap(e)).toList();
  }

  Future<T?> getItem(bool Function(T) where) async {
    final result = await getItems();
    return result.firstWhereOrNull(where);
  }

  Future<void> deleteWhere(bool Function(T value) where) async {
    final items = await getItems();
    items.removeWhere(where);
    await _salvar(items);
  }

  Future<void> addItem(T item) async {
    final items = await getItems();
    items.add(item);
    await _salvar(items);
  }

  Future<T> editarItem(T Function(T oldItem) item, bool Function(T e) where) async {
    final items = await getItems();
    final index = items.indexWhere(where);
    items[index] = item(items[index]);
    await _salvar(items);
    return items[index];
  }

  _salvar(List<T> items) async {
    await _completer.future;
    await _prefs.setString(
      key,
      jsonEncode(items.map((e) => toMap(e)).toList()),
    );
  }
}
