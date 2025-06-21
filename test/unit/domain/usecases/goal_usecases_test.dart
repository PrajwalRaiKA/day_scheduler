import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:day_scheduler/features/goals/domain/entities/goal.dart';
import 'package:day_scheduler/features/goals/domain/usecases/goal_usecases.dart';
import 'package:day_scheduler/features/goals/data/goals_repository_impl.dart';

import 'goal_usecases_test.mocks.dart';

@GenerateMocks([IGoalsRepository])
void main() {
  group('Goal Use Cases Tests', () {
    late MockIGoalsRepository mockRepository;
    late GetGoalsByDate getGoalsByDate;
    late AddGoal addGoal;
    late UpdateGoal updateGoal;
    late DeleteGoal deleteGoal;

    const testGoal = Goal(
      id: '1',
      title: 'Test Goal',
      description: 'Test Description',
      date: '2024-01-01',
    );

    const testDate = '2024-01-01';

    setUp(() {
      mockRepository = MockIGoalsRepository();
      getGoalsByDate = GetGoalsByDate(mockRepository);
      addGoal = AddGoal(mockRepository);
      updateGoal = UpdateGoal(mockRepository);
      deleteGoal = DeleteGoal(mockRepository);
    });

    group('GetGoalsByDate', () {
      test('should get goals by date from repository', () async {
        // arrange
        final goals = [testGoal];
        when(mockRepository.getGoalsByDate(testDate))
            .thenAnswer((_) async => goals);

        // act
        final result = await getGoalsByDate(testDate);

        // assert
        expect(result, goals);
        verify(mockRepository.getGoalsByDate(testDate));
        verifyNoMoreInteractions(mockRepository);
      });

      test('should return empty list when no goals found', () async {
        // arrange
        when(mockRepository.getGoalsByDate(testDate))
            .thenAnswer((_) async => <Goal>[]);

        // act
        final result = await getGoalsByDate(testDate);

        // assert
        expect(result, isEmpty);
        verify(mockRepository.getGoalsByDate(testDate));
        verifyNoMoreInteractions(mockRepository);
      });
    });

    group('AddGoal', () {
      test('should add goal to repository', () async {
        // arrange
        when(mockRepository.addGoal(testGoal))
            .thenAnswer((_) async => unit);

        // act
        await addGoal(testGoal);

        // assert
        verify(mockRepository.addGoal(testGoal));
        verifyNoMoreInteractions(mockRepository);
      });

      test('should handle repository errors', () async {
        // arrange
        when(mockRepository.addGoal(testGoal))
            .thenThrow(Exception('Database error'));

        // act & assert
        expect(() => addGoal(testGoal), throwsException);
        verify(mockRepository.addGoal(testGoal));
        verifyNoMoreInteractions(mockRepository);
      });
    });

    group('UpdateGoal', () {
      test('should update goal in repository', () async {
        // arrange
        when(mockRepository.updateGoal(testGoal))
            .thenAnswer((_) async => unit);

        // act
        await updateGoal(testGoal);

        // assert
        verify(mockRepository.updateGoal(testGoal));
        verifyNoMoreInteractions(mockRepository);
      });

      test('should handle repository errors during update', () async {
        // arrange
        when(mockRepository.updateGoal(testGoal))
            .thenThrow(Exception('Update failed'));

        // act & assert
        expect(() => updateGoal(testGoal), throwsException);
        verify(mockRepository.updateGoal(testGoal));
        verifyNoMoreInteractions(mockRepository);
      });
    });

    group('DeleteGoal', () {
      test('should delete goal from repository', () async {
        // arrange
        when(mockRepository.deleteGoal(testGoal.id))
            .thenAnswer((_) async => unit);

        // act
        await deleteGoal(testGoal.id);

        // assert
        verify(mockRepository.deleteGoal(testGoal.id));
        verifyNoMoreInteractions(mockRepository);
      });

      test('should handle repository errors during deletion', () async {
        // arrange
        when(mockRepository.deleteGoal(testGoal.id))
            .thenThrow(Exception('Delete failed'));

        // act & assert
        expect(() => deleteGoal(testGoal.id), throwsException);
        verify(mockRepository.deleteGoal(testGoal.id));
        verifyNoMoreInteractions(mockRepository);
      });
    });
  });
} 