import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/todo_usecases.dart';
import 'package:equatable/equatable.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final GetTodosByDate getTodosByDate;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodosBloc({
    required this.getTodosByDate,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) async {
      emit(TodosLoading());
      try {
        final todos = await getTodosByDate(event.date);
        emit(TodosLoaded(todos));
      } catch (e) {
        emit(TodosError(e.toString()));
      }
    });
    on<AddTodoEvent>((event, emit) async {
      try {
        await addTodo(event.todo);
        add(LoadTodosEvent(event.todo.date));
      } catch (e) {
        emit(TodosError(e.toString()));
      }
    });
    on<UpdateTodoEvent>((event, emit) async {
      try {
        await updateTodo(event.todo);
        add(LoadTodosEvent(event.todo.date));
      } catch (e) {
        emit(TodosError(e.toString()));
      }
    });
    on<DeleteTodoEvent>((event, emit) async {
      try {
        await deleteTodo(event.todoId);
        add(LoadTodosEvent(event.date));
      } catch (e) {
        emit(TodosError(e.toString()));
      }
    });
  }
} 