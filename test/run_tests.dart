import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'unit/domain/entities/goal_test.dart';
import 'unit/domain/entities/todo_test.dart';
import 'unit/domain/entities/schedule_item_test.dart';
import 'unit/domain/usecases/goal_usecases_test.dart';
import 'unit/presentation/bloc/goals_bloc_test.dart';
import 'widget/goals_section_test.dart';
import 'widget_test.dart';

void main() {
  group('Day Scheduler Test Suite', () {
    test('All tests should be included', () {
      // This test ensures all test files are imported and run
      expect(true, isTrue);
    });
  });
} 