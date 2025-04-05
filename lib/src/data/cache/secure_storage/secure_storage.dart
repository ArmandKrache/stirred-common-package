import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

/// An interface providing [FlutterSecureStorage] methods.
///
/// This is used to store, read, or delete a single value of type [T] into an
/// encrypted persistent cache. The data is located under a key, [storageKey].
class SecureStorage<T> {
  const SecureStorage();

  /// Used to access the storage of [FlutterSecureStorage].
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  /// Fetches the data from the cache and deserialize it.
  Future<T?> read<T>(String key) async {
    final value = await _storage.read(key: key);

    return value == null ? null : deserialize<T>(value);
  }

  /// Serializes the data and save it to the cache.
  Future<void> save<T>(String key, T value) {
    return _storage.write(key: key, value: serialize(value));
  }

  /// Removes the data from the cache.
  Future<void> remove(String key) {
    return _storage.delete(key: key);
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

enum StorageKeys {
  firebaseToken(value: 'firebase_token');

  const StorageKeys({required this.value});

  final String value;
}
