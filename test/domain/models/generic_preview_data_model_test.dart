import 'package:stirred_common_domain/src/domain/models/generic_preview_data_model.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('GenericPreviewDataModel', () {
    test('should create a model with required fields', () {
      const model = GenericPreviewDataModel(
        id: 'test-id',
        name: 'Test Name',
      );

      expect(model.id, 'test-id');
      expect(model.name, 'Test Name');
      expect(model.description, ''); // Default value
      expect(model.picture, null);
    });

    test('should create a model with all fields', () {
      const model = GenericPreviewDataModel(
        id: 'test-id',
        name: 'Test Name',
        description: 'Test Description',
        picture: 'test-picture.jpg',
      );

      expect(model.id, 'test-id');
      expect(model.name, 'Test Name');
      expect(model.description, 'Test Description');
      expect(model.picture, 'test-picture.jpg');
    });

    test('should serialize to JSON', () {
      const model = GenericPreviewDataModel(
        id: 'test-id',
        name: 'Test Name',
        description: 'Test Description',
        picture: 'test-picture.jpg',
      );

      final json = model.toJson();
      
      expect(json['id'], 'test-id');
      expect(json['name'], 'Test Name');
      expect(json['description'], 'Test Description');
      expect(json['picture'], 'test-picture.jpg');
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'test-id',
        'name': 'Test Name',
        'description': 'Test Description',
        'picture': 'test-picture.jpg',
      };

      final model = GenericPreviewDataModel.fromJson(json);
      
      expect(model.id, 'test-id');
      expect(model.name, 'Test Name');
      expect(model.description, 'Test Description');
      expect(model.picture, 'test-picture.jpg');
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'test-id',
        'name': 'Test Name',
      };

      final model = GenericPreviewDataModel.fromJson(json);
      
      expect(model.id, 'test-id');
      expect(model.name, 'Test Name');
      expect(model.description, ''); // Default value
      expect(model.picture, null);
    });
  });
} 