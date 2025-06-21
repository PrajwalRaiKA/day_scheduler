import 'package:flutter_test/flutter_test.dart';
import 'package:day_scheduler/features/goals/domain/entities/goal.dart';

void main() {
  group('Goal Entity Tests', () {
    const testGoal = Goal(
      id: '1',
      title: 'Test Goal',
      description: 'Test Description',
      date: '2024-01-01',
    );

    test('should create a Goal with all properties', () {
      expect(testGoal.id, '1');
      expect(testGoal.title, 'Test Goal');
      expect(testGoal.description, 'Test Description');
      expect(testGoal.date, '2024-01-01');
    });

    test('should create a Goal without description', () {
      const goalWithoutDescription = Goal(
        id: '2',
        title: 'Test Goal 2',
        date: '2024-01-02',
      );

      expect(goalWithoutDescription.id, '2');
      expect(goalWithoutDescription.title, 'Test Goal 2');
      expect(goalWithoutDescription.description, isNull);
      expect(goalWithoutDescription.date, '2024-01-02');
    });

    test('should be equal when all properties are the same', () {
      const goal1 = Goal(
        id: '1',
        title: 'Test Goal',
        description: 'Test Description',
        date: '2024-01-01',
      );

      const goal2 = Goal(
        id: '1',
        title: 'Test Goal',
        description: 'Test Description',
        date: '2024-01-01',
      );

      expect(goal1, equals(goal2));
    });

    test('should not be equal when properties are different', () {
      const goal1 = Goal(
        id: '1',
        title: 'Test Goal',
        description: 'Test Description',
        date: '2024-01-01',
      );

      const goal2 = Goal(
        id: '2',
        title: 'Test Goal',
        description: 'Test Description',
        date: '2024-01-01',
      );

      expect(goal1, isNot(equals(goal2)));
    });

    test('copyWith should return a new instance with updated properties', () {
      final updatedGoal = testGoal.copyWith(
        title: 'Updated Goal',
        description: 'Updated Description',
      );

      expect(updatedGoal.id, testGoal.id);
      expect(updatedGoal.title, 'Updated Goal');
      expect(updatedGoal.description, 'Updated Description');
      expect(updatedGoal.date, testGoal.date);
      expect(updatedGoal, isNot(same(testGoal)));
    });

    test('copyWith should return same instance when no properties are provided', () {
      final copiedGoal = testGoal.copyWith();

      expect(copiedGoal, equals(testGoal));
    });

    test('fromJson should create Goal from JSON', () {
      final json = {
        'id': '1',
        'title': 'Test Goal',
        'description': 'Test Description',
        'date': '2024-01-01',
      };

      final goal = Goal.fromJson(json);

      expect(goal.id, '1');
      expect(goal.title, 'Test Goal');
      expect(goal.description, 'Test Description');
      expect(goal.date, '2024-01-01');
    });

    test('toJson should convert Goal to JSON', () {
      final json = testGoal.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Goal');
      expect(json['description'], 'Test Description');
      expect(json['date'], '2024-01-01');
    });

    test('toJson should handle null description', () {
      const goalWithoutDescription = Goal(
        id: '2',
        title: 'Test Goal 2',
        date: '2024-01-02',
      );

      final json = goalWithoutDescription.toJson();

      expect(json['id'], '2');
      expect(json['title'], 'Test Goal 2');
      expect(json['description'], isNull);
      expect(json['date'], '2024-01-02');
    });
  });
} 