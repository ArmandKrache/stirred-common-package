import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/data/cache/secure_storage/secure_storage.dart';
import 'package:stirred_common_domain/src/data/providers.dart';
import 'package:stirred_common_domain/src/domain/repositories/admin_repository.dart';
import 'package:stirred_common_domain/src/domain/repositories/drinks_repository.dart';
import 'package:stirred_common_domain/src/domain/repositories/profile_repository.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return const SecureStorage();
});

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  return AdminRepository(
    authApi: ref.watch(authApiServiceProvider),
    sharedPreferencesStorage: ref.watch(sharedPreferencesStorageProvider),
  );
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(
    profileApi: ref.watch(profileApiServiceProvider),
  );
});

final drinksRepositoryProvider = Provider<DrinksRepository>((ref) {
  return DrinksRepository(
    drinksApi: ref.watch(drinksApiServiceProvider),
  );
});
