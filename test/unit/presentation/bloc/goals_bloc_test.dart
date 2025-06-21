import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:day_scheduler/features/goals/domain/entities/goal.dart';
import 'package:day_scheduler/features/goals/domain/usecases/goal_usecases.dart';
import 'package:day_scheduler/features/goals/presentation/bloc/goals_bloc.dart';
import 'package:day_scheduler/features/goals/presentation/bloc/goals_event.dart';
import 'package:day_scheduler/features/goals/presentation/bloc/goals_state.dart';

import 'goals_bloc_test.mocks.dart';

@GenerateMocks([GetGoalsByDate, AddGoal, UpdateGoal, DeleteGoal])
void main() {
  group('GoalsBloc Tests', () {
    late MockGetGoalsByDate mockGetGoalsByDate;
    late MockAddGoal mockAddGoal;
    late MockUpdateGoal mockUpdateGoal;
    late MockDeleteGoal mockDeleteGoal;
    late GoalsBloc goalsBloc;

    const testGoal = Goal(
      id: '1',
      title: 'Test Goal',
      description: 'Test Description',
      date: '2024-01-01',
    );

    const testDate = '2024-01-01';

    setUp(() {
      mockGetGoalsByDate = MockGetGoalsByDate();
      mockAddGoal = MockAddGoal();
      mockUpdateGoal = MockUpdateGoal();
      mockDeleteGoal = MockDeleteGoal();
      
      goalsBloc = GoalsBloc(
        getGoalsByDate: mockGetGoalsByDate,
        addGoal: mockAddGoal,
        updateGoal: mockUpdateGoal,
        deleteGoal: mockDeleteGoal,
      );
    });

    tearDown(() {
      goalsBloc.close();
    });

    test('initial state should be GoalsInitial', () {
      expect(goalsBloc.state, isA<GoalsInitial>());
    });

    group('LoadGoalsEvent', () {
      blocTest<GoalsBloc, GoalsState>(
        'emits [GoalsLoading, GoalsLoaded] when LoadGoalsEvent is added and goals are found',
        build: () {
          when(mockGetGoalsByDate(testDate))
              .thenAnswer((_) async => [testGoal]);
          return goalsBloc;
        },
        act: (bloc) => bloc.add(LoadGoalsEvent(testDate)),
        expect: () => [
          isA<GoalsLoading>(),
          isA<GoalsLoaded>(),
        ],
        verify: (_) {
          verify(mockGetGoalsByDate(testDate)).called(1);
        },
      );

      blocTest<GoalsBloc, GoalsState>(
        'emits [GoalsLoading, GoalsLoaded] with empty list when no goals found',
        build: () {
          when(mockGetGoalsByDate(testDate))
              .thenAnswer((_) async => <Goal>[]);
          return goalsBloc;
        },
        act: (bloc) => bloc.add(LoadGoalsEvent(testDate)),
        expect: () => [
          isA<GoalsLoading>(),
          isA<GoalsLoaded>(),
        ],
        verify: (_) {
          verify(mockGetGoalsByDate(testDate)).called(1);
        },
      );

      blocTest<GoalsBloc, GoalsState>(
        'emits [GoalsLoading, GoalsError] when LoadGoalsEvent fails',
        build: () {
          when(mockGetGoalsByDate(testDate))
              .thenThrow(Exception('Database error'));
          return goalsBloc;
        },
        act: (bloc) => bloc.add(LoadGoalsEvent(testDate)),
        expect: () => [
          isA<GoalsLoading>(),
          isA<GoalsError>(),
        ],
        verify: (_) {
          verify(mockGetGoalsByDate(testDate)).called(1);
        },
      );
    });

    group('AddGoalEvent', () {
      blocTest<GoalsBloc, GoalsState>(
        'emits [GoalsLoaded] when AddGoalEvent is added successfully',
        build: () {
          when(mockAddGoal(testGoal))
              .thenAnswer((_) async => unit);
          when(mockGetGoalsByDate(testDate))
              .thenAnswer((_) async => [testGoal]);
          return goalsBloc;
        },
        act: (bloc) => bloc.add(AddGoalEvent(testGoal)),
        expect: () => [
          isA<GoalsLoaded>(),
        ],
        verify: (_) {
          verify(mockAddGoal(testGoal)).called(1);
          verify(mockGetGoalsByDate(testDate)).called(1);
        },
      );

      blocTest<GoalsBloc, GoalsState>(
        'emits [GoalsError] when AddGoalEvent fails',
        build: () {
          when(mockAddGoal(testGoal))
              .thenThrow(Exception('Add failed'));
          return goalsBloc;
        },
        act: (bloc) => bloc.add(AddGoalEvent(testGoal)),
        expect: () => [
          isA<GoalsError>(),
        ],
        verify: (_) {
          verify(mockAddGoal(testGoal)).called(1);
        },
      );
    });

    group('UpdateGoalEvent', () {
      blocTest<GoalsBloc, GoalsState>(
        'emits [GoalsLoaded] when UpdateGoalEvent is added successfully',
        build: () {
          when(mockUpdateGoal(testGoal))
              .thenAnswer((_) async => unit);
          when(mockGetGoalsByDate(testDate))
              .thenAnswer((_) async => [testGoal]);
          return goalsBloc;
        },
        act: (bloc) => bloc.add(UpdateGoalEvent(testGoal)),
        expect: () => [
          isA<GoalsLoaded>(),
        ],
        verify: (_) {
          verify(mockUpdateGoal(testGoal)).called(1);
          verify(mockGetGoalsByDate(testDate)).called(1);
        },
      );

      blocTest<GoalsBloc, GoalsState>(
        'emits [GoalsError] when UpdateGoalEvent fails',
        build: () {
          when(mockUpdateGoal(testGoal))
              .thenThrow(Exception('Update failed'));
          return goalsBloc;
        },
        act: (bloc) => bloc.add(UpdateGoalEvent(testGoal)),
        expect: () => [
          isA<GoalsError>(),
        ],
        verify: (_) {
          verify(mockUpdateGoal(testGoal)).called(1);
        },
      );
    });

    group('DeleteGoalEvent', () {
      blocTest<GoalsBloc, GoalsState>(
        'emits [GoalsLoaded] when DeleteGoalEvent is added successfully',
        build: () {
          when(mockDeleteGoal(testGoal.id))
              .thenAnswer((_) async => unit);
          when(mockGetGoalsByDate(testDate))
              .thenAnswer((_) async => <Goal>[]);
          return goalsBloc;
        },
        act: (bloc) => bloc.add(DeleteGoalEvent(testGoal.id, testDate)),
        expect: () => [
          isA<GoalsLoaded>(),
        ],
        verify: (_) {
          verify(mockDeleteGoal(testGoal.id)).called(1);
          verify(mockGetGoalsByDate(testDate)).called(1);
        },
      );

      blocTest<GoalsBloc, GoalsState>(
        'emits [GoalsError] when DeleteGoalEvent fails',
        build: () {
          when(mockDeleteGoal(testGoal.id))
              .thenThrow(Exception('Delete failed'));
          return goalsBloc;
        },
        act: (bloc) => bloc.add(DeleteGoalEvent(testGoal.id, testDate)),
        expect: () => [
          isA<GoalsError>(),
        ],
        verify: (_) {
          verify(mockDeleteGoal(testGoal.id)).called(1);
        },
      );
    });
  });
} 