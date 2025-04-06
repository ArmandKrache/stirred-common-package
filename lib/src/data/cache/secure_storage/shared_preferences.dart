import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';

/// An interface providing [FlutterSecureStorage] methods.
///
/// This is used to store, read, or delete a single value of type [T] into an
/// encrypted persistent cache. The data is located under a key, [storageKey].
class SharedPreferencesStorage<T> {
  const SharedPreferencesStorage();

  /// Used to access the storage of [FlutterSecureStorage].
  static Future<SharedPreferences> get _instance async => await SharedPreferences.getInstance();

  /// Fetches the data from the cache and deserialize it.
  Future<T?> read<T>(String key) async {
    final value = (await _instance).getString(key);
    return value == null ? null : deserialize<T>(value);
  }

  /// Serializes the data and save it to the cache.
  Future<bool> save<T>(String key, T value) async {
    return (await _instance).setString(key, serialize(value));
  }

  /// Removes the data from the cache.
  Future<bool> remove(String key) async {
    return (await _instance).remove(key);
  }

  /// Used to serialize the data to a JSON string when saving a value.
  static String serialize(dynamic value) {
    switch (value) {
      case int _:
      case double _:
      case bool _:
      case String _:
      case DateTime _:
        return value.toString();
      case Map<String, dynamic> _:
        return jsonEncode(value);
      case Profile _:
        return jsonEncode(value.toJson());
      default:
        return _stirredModelSerializer(value);
    }
  }

  static String _stirredModelSerializer(dynamic value) {
    switch (value) {
      case Profile _:
        return jsonEncode(value.toJson());
      default:
        throw UnsupportedError('Type ${value.runtimeType} is not supported');
    }
  }


  /// Used to deserialize the data from a JSON string fetched from the cache.
  static T deserialize<T>(String value) {
    switch (T) {
      case const (int):
        return int.parse(value) as T;
      case const (double):
        return double.parse(value) as T;
      case const (bool):
        return (value.toLowerCase() == 'true') as T;
      case const (String):
        return value as T;
      case const (DateTime):
        return DateTime.parse(value) as T;
      case const (Map<String, dynamic>):
        return jsonDecode(value) as T;
      default:
        return _stirredModelDeserializer<T>(value);
    }
  }

  static T _stirredModelDeserializer<T>(String value) {
    switch (T) {
      case Profile _:
        return Profile.fromJson(jsonDecode(value) as Map<String, dynamic>) as T;
      default:
        throw UnsupportedError('Type $T is not supported');
    }
  }
}

enum PreferencesKeys {
  authToken(value: 'auth_token');

  const PreferencesKeys({required this.value});

  final String value;
}
