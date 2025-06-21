import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:day_scheduler/features/goals/domain/entities/goal.dart';
import 'package:day_scheduler/features/goals/presentation/bloc/goals_bloc.dart';
import 'package:day_scheduler/features/goals/presentation/bloc/goals_event.dart';
import 'package:day_scheduler/features/goals/presentation/bloc/goals_state.dart';
import 'package:day_scheduler/features/goals/presentation/widgets/goals_section.dart';

import 'goals_section_test.mocks.dart';

@GenerateMocks([GoalsBloc])
void main() {
  group('GoalsSection Widget Tests', () {
    late MockGoalsBloc mockGoalsBloc;
    late List<Goal> testGoals;
    const testDate = '2024-01-01';

    setUp(() {
      mockGoalsBloc = MockGoalsBloc();
      testGoals = [
        const Goal(
          id: '1',
          title: 'Test Goal 1',
          description: 'Test Description 1',
          date: '2024-01-01',
        ),
        const Goal(
          id: '2',
          title: 'Test Goal 2',
          description: 'Test Description 2',
          date: '2024-01-01',
        ),
      ];
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider<GoalsBloc>.value(
            value: mockGoalsBloc,
            child: GoalsSection(selectedDate: testDate),
          ),
        ),
      );
    }

    testWidgets('should display loading indicator when state is GoalsLoading',
        (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoading());

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display goals when state is GoalsLoaded with goals',
        (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded(testGoals));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('Goals'), findsOneWidget);
      expect(find.text('Test Goal 1'), findsOneWidget);
      expect(find.text('Test Goal 2'), findsOneWidget);
      expect(find.text('Test Description 1'), findsOneWidget);
      expect(find.text('Test Description 2'), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(3)); // 2 goal cards + 1 main card
    });

    testWidgets('should display empty state when no goals found',
        (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded([]));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('Goals'), findsOneWidget);
      expect(find.text('No goals for this date'), findsOneWidget);
      expect(find.text('Tap "Add" to create your first goal'), findsOneWidget);
      expect(find.byIcon(Icons.flag_outlined), findsOneWidget);
    });

    testWidgets('should display error message when state is GoalsError',
        (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(const GoalsError('Test error'));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('Goals'), findsOneWidget);
      expect(find.text('Error: Test error'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('should navigate to add goal screen when Add button is tapped',
        (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded([]));

      // act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // assert
      expect(find.text('Add Goal'), findsOneWidget);
    });

    testWidgets('should show delete option when goal is long pressed',
        (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded(testGoals));

      // act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.longPress(find.text('Test Goal 1'));
      await tester.pumpAndSettle();

      // assert
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('should call delete event when delete is selected',
        (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded(testGoals));

      // act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.longPress(find.text('Test Goal 1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // assert
      verify(mockGoalsBloc.add(DeleteGoalEvent('1', testDate))).called(1);
    });

    testWidgets('should display goal with flag icon', (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded(testGoals));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byIcon(Icons.flag), findsNWidgets(2)); // One for each goal
    });

    testWidgets('should display Add button with correct styling',
        (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded([]));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      final addButton = find.byType(ElevatedButton);
      expect(addButton, findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should handle goal with null description',
        (WidgetTester tester) async {
      // arrange
      final goalsWithNullDescription = [
        const Goal(
          id: '1',
          title: 'Test Goal',
          date: '2024-01-01',
        ),
      ];
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded(goalsWithNullDescription));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('Test Goal'), findsOneWidget);
      expect(find.text('Test Description'), findsNothing);
    });
  });
} 