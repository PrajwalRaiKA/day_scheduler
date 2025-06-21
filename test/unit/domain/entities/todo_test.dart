import 'package:flutter_test/flutter_test.dart';
import 'package:day_scheduler/features/todos/domain/entities/todo.dart';

void main() {
  group('Todo Entity Tests', () {
    const testTodo = Todo(
      id: '1',
      title: 'Test Todo',
      description: 'Test Description',
      isCompleted: false,
      date: '2024-01-01',
    );

    test('should create a Todo with all properties', () {
      expect(testTodo.id, '1');
      expect(testTodo.title, 'Test Todo');
      expect(testTodo.description, 'Test Description');
      expect(testTodo.isCompleted, false);
      expect(testTodo.date, '2024-01-01');
    });

    test('should create a Todo without description', () {
      const todoWithoutDescription = Todo(
        id: '2',
        title: 'Test Todo 2',
        isCompleted: true,
        date: '2024-01-02',
      );

      expect(todoWithoutDescription.id, '2');
      expect(todoWithoutDescription.title, 'Test Todo 2');
      expect(todoWithoutDescription.description, isNull);
      expect(todoWithoutDescription.isCompleted, true);
      expect(todoWithoutDescription.date, '2024-01-02');
    });

    test('should be equal when all properties are the same', () {
      const todo1 = Todo(
        id: '1',
        title: 'Test Todo',
        description: 'Test Description',
        isCompleted: false,
        date: '2024-01-01',
      );

      const todo2 = Todo(
        id: '1',
        title: 'Test Todo',
        description: 'Test Description',
        isCompleted: false,
        date: '2024-01-01',
      );

      expect(todo1, equals(todo2));
    });

    test('should not be equal when properties are different', () {
      const todo1 = Todo(
        id: '1',
        title: 'Test Todo',
        description: 'Test Description',
        isCompleted: false,
        date: '2024-01-01',
      );

      const todo2 = Todo(
        id: '1',
        title: 'Test Todo',
        description: 'Test Description',
        isCompleted: true,
        date: '2024-01-01',
      );

      expect(todo1, isNot(equals(todo2)));
    });

    test('copyWith should return a new instance with updated properties', () {
      final updatedTodo = testTodo.copyWith(
        title: 'Updated Todo',
        description: 'Updated Description',
        isCompleted: true,
      );

      expect(updatedTodo.id, testTodo.id);
      expect(updatedTodo.title, 'Updated Todo');
      expect(updatedTodo.description, 'Updated Description');
      expect(updatedTodo.isCompleted, true);
      expect(updatedTodo.date, testTodo.date);
      expect(updatedTodo, isNot(same(testTodo)));
    });

    test('copyWith should return same instance when no properties are provided', () {
      final copiedTodo = testTodo.copyWith();

      expect(copiedTodo, equals(testTodo));
    });

    test('fromJson should create Todo from JSON', () {
      final json = {
        'id': '1',
        'title': 'Test Todo',
        'description': 'Test Description',
        'isCompleted': false,
        'date': '2024-01-01',
      };

      final todo = Todo.fromJson(json);

      expect(todo.id, '1');
      expect(todo.title, 'Test Todo');
      expect(todo.description, 'Test Description');
      expect(todo.isCompleted, false);
      expect(todo.date, '2024-01-01');
    });

    test('toJson should convert Todo to JSON', () {
      final json = testTodo.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Todo');
      expect(json['description'], 'Test Description');
      expect(json['isCompleted'], false);
      expect(json['date'], '2024-01-01');
    });

    test('toJson should handle null description', () {
      const todoWithoutDescription = Todo(
        id: '2',
        title: 'Test Todo 2',
        isCompleted: true,
        date: '2024-01-02',
      );

      final json = todoWithoutDescription.toJson();

      expect(json['id'], '2');
      expect(json['title'], 'Test Todo 2');
      expect(json['description'], isNull);
      expect(json['isCompleted'], true);
      expect(json['date'], '2024-01-02');
    });

    test('should toggle completion status', () {
      final completedTodo = testTodo.copyWith(isCompleted: true);
      expect(completedTodo.isCompleted, true);

      final uncompletedTodo = completedTodo.copyWith(isCompleted: false);
      expect(uncompletedTodo.isCompleted, false);
    });
  });
} 