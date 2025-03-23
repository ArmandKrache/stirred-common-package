// ignore: unused_import
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';

Future<void> saveAccessToken(String token) async {
  await storage.write(key: 'access_token', value: token);
}

Future<void> saveRefreshToken(String token) async {
  await storage.write(key: 'refresh_token', value: token);
}

// Retrieve access token
Future<String?> readAccessToken() async {
  return await storage.read(key: 'access_token');
}

Future<String?> readRefreshToken() async {
  return await storage.read(key: 'refresh_token');
}

// Remove access token
Future<void> deleteTokens() async {
  await storage.delete(key: 'access_token');
  await storage.delete(key: 'refresh_token');
}

Future<String?> refreshToken(ApiRepository apiRepository) async {
  String? token = await readRefreshToken();
  if (token == null) {
    return null;
  }
  final refreshResponse = await apiRepository.refreshToken(refreshToken: token);
  if (refreshResponse is DataSuccess) {
    await saveAccessToken(refreshResponse.data!.access);
    return await readAccessToken();
  }
  return null;
}
