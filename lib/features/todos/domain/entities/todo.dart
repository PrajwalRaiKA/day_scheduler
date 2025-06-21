import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const Todo._();
  const factory Todo({
    required String id,
    required String title,
    String? description,
    required bool isCompleted,
    required DateTime date,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  @override
  // TODO: implement date
  DateTime get date => throw UnimplementedError();

  @override
  // TODO: implement description
  String? get description => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement isCompleted
  bool get isCompleted => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
} 