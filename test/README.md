# Day Scheduler Test Suite

This directory contains comprehensive tests for the Day Scheduler Flutter application, following clean architecture principles and testing best practices.

## Test Structure

```
test/
├── unit/                          # Unit tests
│   ├── domain/                    # Domain layer tests
│   │   ├── entities/              # Entity tests
│   │   │   ├── goal_test.dart
│   │   │   ├── todo_test.dart
│   │   │   └── schedule_item_test.dart
│   │   └── usecases/              # Use case tests
│   │       └── goal_usecases_test.dart
│   └── presentation/              # Presentation layer tests
│       └── bloc/                  # BLoC tests
│           └── goals_bloc_test.dart
├── widget/                        # Widget tests
│   └── goals_section_test.dart
├── integration/                   # Integration tests (future)
├── run_tests.dart                 # Test runner
├── widget_test.dart               # Main app widget test
└── README.md                      # This file
```

## Test Categories

### 1. Unit Tests (`test/unit/`)

#### Domain Layer Tests
- **Entity Tests**: Test domain entities (Goal, Todo, ScheduleItem)
  - Property validation
  - Equality comparisons
  - `copyWith` functionality
  - JSON serialization/deserialization

- **Use Case Tests**: Test business logic use cases
  - CRUD operations
  - Error handling
  - Repository interactions

#### Presentation Layer Tests
- **BLoC Tests**: Test state management
  - Event handling
  - State transitions
  - Error states
  - Loading states

### 2. Widget Tests (`test/widget/`)

- **Component Tests**: Test individual widgets
  - UI rendering
  - User interactions
  - State binding
  - Navigation

### 3. Integration Tests (`test/integration/`)

- **End-to-End Tests**: Test complete user workflows
  - Full app functionality
  - Database operations
  - User journeys

## Running Tests

### Prerequisites

1. Install dependencies:
```bash
flutter pub get
```

2. Generate mock files:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running All Tests

```bash
flutter test
```

### Running Specific Test Categories

```bash
# Unit tests only
flutter test test/unit/

# Widget tests only
flutter test test/widget/

# Specific test file
flutter test test/unit/domain/entities/goal_test.dart
```

### Running Tests with Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Running Tests in Watch Mode

```bash
flutter test --watch
```

## Test Dependencies

- **flutter_test**: Core Flutter testing framework
- **mockito**: Mocking library for creating test doubles
- **bloc_test**: Testing utilities for BLoC pattern
- **build_runner**: Code generation for mocks

## Test Best Practices

### 1. Test Organization
- Follow the same structure as the main code
- Use descriptive test names
- Group related tests using `group()`

### 2. Test Structure (AAA Pattern)
```dart
test('should do something when condition is met', () {
  // Arrange - Set up test data and mocks
  final testData = TestData();
  when(mock.doSomething()).thenReturn(result);

  // Act - Execute the code being tested
  final result = sut.doSomething(testData);

  // Assert - Verify the expected outcome
  expect(result, expectedValue);
  verify(mock.doSomething()).called(1);
});
```

### 3. Mocking Guidelines
- Mock external dependencies (repositories, APIs)
- Use `@GenerateMocks()` annotation for automatic mock generation
- Verify mock interactions to ensure proper usage

### 4. Widget Testing
- Test user interactions (tap, long press, etc.)
- Verify UI state changes
- Test error and loading states
- Mock BLoC dependencies

### 5. BLoC Testing
- Test all events and state transitions
- Verify error handling
- Test loading states
- Use `blocTest()` for complex scenarios

## Adding New Tests

### 1. Entity Tests
```dart
test('should create entity with all properties', () {
  final entity = Entity(id: '1', name: 'Test');
  expect(entity.id, '1');
  expect(entity.name, 'Test');
});
```

### 2. Use Case Tests
```dart
test('should call repository method', () async {
  when(mockRepository.getData()).thenAnswer((_) async => data);
  await useCase.execute();
  verify(mockRepository.getData()).called(1);
});
```

### 3. BLoC Tests
```dart
blocTest<MyBloc, MyState>(
  'emits [Loading, Loaded] when LoadEvent is added',
  build: () => MyBloc(),
  act: (bloc) => bloc.add(LoadEvent()),
  expect: () => [Loading(), Loaded()],
);
```

### 4. Widget Tests
```dart
testWidgets('should display data when loaded', (tester) async {
  when(mockBloc.state).thenReturn(Loaded(data));
  await tester.pumpWidget(MyWidget());
  expect(find.text('Data'), findsOneWidget);
});
```

## Continuous Integration

Tests are automatically run in CI/CD pipelines:

1. **Pre-commit**: Run unit tests
2. **Pull Request**: Run all tests with coverage
3. **Main Branch**: Run full test suite

## Coverage Goals

- **Unit Tests**: >90% coverage
- **Widget Tests**: >80% coverage
- **Integration Tests**: >70% coverage

## Troubleshooting

### Common Issues

1. **Mock Generation Fails**
   ```bash
   flutter pub run build_runner clean
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

2. **Test Dependencies Missing**
   ```bash
   flutter pub get
   ```

3. **BLoC Tests Fail**
   - Ensure BLoC is properly closed in `tearDown()`
   - Check mock setup and verification

4. **Widget Tests Fail**
   - Ensure proper widget tree setup
   - Check for missing dependencies
   - Verify mock state setup

### Debugging Tests

```bash
# Run tests with verbose output
flutter test --verbose

# Run specific test with debugging
flutter test test/unit/domain/entities/goal_test.dart --verbose
```

## Contributing

When adding new features:

1. Write tests first (TDD approach)
2. Ensure all tests pass
3. Maintain or improve coverage
4. Update this README if needed

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [BLoC Testing Guide](https://bloclibrary.dev/#/testing)
- [Mockito Documentation](https://pub.dev/packages/mockito)
- [Flutter Test Coverage](https://docs.flutter.dev/testing#coverage) 