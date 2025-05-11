import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:stirred_common_domain/src/domain/models/preferences/preferences.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../utils/test_models.dart';

void main() {
  group('Profile', () {
    test('should create a profile with required fields', () {
      const profile = TestModels.minimalProfile;

      expect(profile.id, 'test-profile-id');
      expect(profile.email, '');
      expect(profile.name, '');
      expect(profile.description, '');
      expect(profile.picture, '');
      expect(profile.dateOfBirth, '');
      expect(profile.preferences, Preferences());
    });

    test('should create a profile with all fields', () {
      const profile = TestModels.fullProfile;

      expect(profile.id, 'test-profile-id');
      expect(profile.email, 'test@example.com');
      expect(profile.name, 'Test Profile Name');
      expect(profile.description, 'Test Profile Description');
      expect(profile.picture, 'test-profile-picture.jpg');
      expect(profile.dateOfBirth, '1990-01-01');
      expect(profile.preferences, Preferences());
    });

    test('should serialize to JSON', () {
      const profile = TestModels.fullProfile;
      final json = profile.toJson();
      
      expect(json['id'], 'test-profile-id');
      expect(json['name'], 'Test Profile Name');
      expect(json['description'], 'Test Profile Description');
      expect(json['picture'], 'test-profile-picture.jpg');
      expect(json['date_of_birth'], '1990-01-01');
      expect(json['preferences'], isA<Preferences>());
    });

    test('should deserialize from JSON', () {
      final json = TestModels.fullProfileJson;
      final profile = Profile.fromJson(json);
      
      expect(profile.id, 'test-profile-id');
      expect(profile.email, 'test@example.com');
      expect(profile.name, 'Test Profile Name');
      expect(profile.description, 'Test Profile Description');
      expect(profile.picture, 'test-profile-picture.jpg');
      expect(profile.dateOfBirth, '1990-01-01');
      expect(profile.preferences, Preferences());
    });

    test('should handle missing optional fields in JSON', () {
      final json = TestModels.minimalProfileJson;
      final profile = Profile.fromJson(json);
      
      expect(profile.id, 'test-profile-id');
      expect(profile.email, '');
      expect(profile.name, '');
      expect(profile.description, '');
      expect(profile.picture, '');
      expect(profile.dateOfBirth, '');
      expect(profile.preferences, Preferences());
    });
  });
} 