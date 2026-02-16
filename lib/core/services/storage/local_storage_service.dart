library;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  Future<void> save(String key, dynamic value);
  Future<T?> get<T>(String key);
  Future<bool> remove(String key);
  Future<bool> containsKey(String key);
}

class LocalStorageServiceImpl implements LocalStorageService {
  LocalStorageServiceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> save(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      await _prefs.setString(key, jsonEncode(value));
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    if (!_prefs.containsKey(key)) return null;
    final value = _prefs.get(key);
    if (value == null) return null;
    if (T == String) return value as T?;
    if (T == int) return value as T?;
    if (T == bool) return value as T?;
    if (T == double) return value as T?;
    if (T == List<String>) return value as T?;
    if (value is String && T == Object) return jsonDecode(value) as T?;
    return value as T?;
  }

  @override
  Future<bool> remove(String key) async => await _prefs.remove(key);

  @override
  Future<bool> containsKey(String key) async => _prefs.containsKey(key);
}
