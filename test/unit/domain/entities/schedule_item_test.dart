import 'package:flutter_test/flutter_test.dart';
import 'package:day_scheduler/features/schedule/domain/entities/schedule_item.dart';

void main() {
  group('ScheduleItem Entity Tests', () {
    const testScheduleItem = ScheduleItem(
      id: '1',
      title: 'Test Schedule',
      description: 'Test Description',
      startTime: '09:00',
      endTime: '10:00',
    );

    test('should create a ScheduleItem with all properties', () {
      expect(testScheduleItem.id, '1');
      expect(testScheduleItem.title, 'Test Schedule');
      expect(testScheduleItem.description, 'Test Description');
      expect(testScheduleItem.startTime, '09:00');
      expect(testScheduleItem.endTime, '10:00');
    });

    test('should create a ScheduleItem without description', () {
      const scheduleWithoutDescription = ScheduleItem(
        id: '2',
        title: 'Test Schedule 2',
        startTime: '10:00',
        endTime: '11:00',
      );

      expect(scheduleWithoutDescription.id, '2');
      expect(scheduleWithoutDescription.title, 'Test Schedule 2');
      expect(scheduleWithoutDescription.description, isNull);
      expect(scheduleWithoutDescription.startTime, '10:00');
      expect(scheduleWithoutDescription.endTime, '11:00');
    });

    test('should be equal when all properties are the same', () {
      const schedule1 = ScheduleItem(
        id: '1',
        title: 'Test Schedule',
        description: 'Test Description',
        startTime: '09:00',
        endTime: '10:00',
      );

      const schedule2 = ScheduleItem(
        id: '1',
        title: 'Test Schedule',
        description: 'Test Description',
        startTime: '09:00',
        endTime: '10:00',
      );

      expect(schedule1, equals(schedule2));
    });

    test('should not be equal when properties are different', () {
      const schedule1 = ScheduleItem(
        id: '1',
        title: 'Test Schedule',
        description: 'Test Description',
        startTime: '09:00',
        endTime: '10:00',
      );

      const schedule2 = ScheduleItem(
        id: '1',
        title: 'Test Schedule',
        description: 'Test Description',
        startTime: '10:00',
        endTime: '11:00',
      );

      expect(schedule1, isNot(equals(schedule2)));
    });

    test('copyWith should return a new instance with updated properties', () {
      final updatedSchedule = testScheduleItem.copyWith(
        title: 'Updated Schedule',
        description: 'Updated Description',
        startTime: '11:00',
        endTime: '12:00',
      );

      expect(updatedSchedule.id, testScheduleItem.id);
      expect(updatedSchedule.title, 'Updated Schedule');
      expect(updatedSchedule.description, 'Updated Description');
      expect(updatedSchedule.startTime, '11:00');
      expect(updatedSchedule.endTime, '12:00');
      expect(updatedSchedule, isNot(same(testScheduleItem)));
    });

    test('copyWith should return same instance when no properties are provided', () {
      final copiedSchedule = testScheduleItem.copyWith();

      expect(copiedSchedule, equals(testScheduleItem));
    });

    test('fromJson should create ScheduleItem from JSON', () {
      final json = {
        'id': '1',
        'title': 'Test Schedule',
        'description': 'Test Description',
        'startTime': '09:00',
        'endTime': '10:00',
      };

      final schedule = ScheduleItem.fromJson(json);

      expect(schedule.id, '1');
      expect(schedule.title, 'Test Schedule');
      expect(schedule.description, 'Test Description');
      expect(schedule.startTime, '09:00');
      expect(schedule.endTime, '10:00');
    });

    test('toJson should convert ScheduleItem to JSON', () {
      final json = testScheduleItem.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Schedule');
      expect(json['description'], 'Test Description');
      expect(json['startTime'], '09:00');
      expect(json['endTime'], '10:00');
    });

    test('toJson should handle null description', () {
      const scheduleWithoutDescription = ScheduleItem(
        id: '2',
        title: 'Test Schedule 2',
        startTime: '10:00',
        endTime: '11:00',
      );

      final json = scheduleWithoutDescription.toJson();

      expect(json['id'], '2');
      expect(json['title'], 'Test Schedule 2');
      expect(json['description'], isNull);
      expect(json['startTime'], '10:00');
      expect(json['endTime'], '11:00');
    });

    test('should validate time format', () {
      const validSchedule = ScheduleItem(
        id: '1',
        title: 'Valid Schedule',
        startTime: '09:30',
        endTime: '10:30',
      );

      expect(validSchedule.startTime, '09:30');
      expect(validSchedule.endTime, '10:30');
    });

    test('should handle different time formats', () {
      const scheduleWithDifferentTimes = ScheduleItem(
        id: '1',
        title: 'Different Times',
        startTime: '14:00',
        endTime: '15:30',
      );

      expect(scheduleWithDifferentTimes.startTime, '14:00');
      expect(scheduleWithDifferentTimes.endTime, '15:30');
    });
  });
} 