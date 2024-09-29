import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

String getUuid() {
  return Uuid().v4();
}

@immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String description;
  final String id;
  final bool completed;

  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

class TodoList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [
        const Todo(id: 'todo-0', description: 'クッキーを買いに行く'),
        const Todo(
          id: 'todo-1',
          description: 'Riverpod にスターをつける',
          completed: true,
        ),
        const Todo(id: 'todo-2', description: '本を売りにいく'),
        const Todo(id: 'todo-3', description: '履修登録をする'),
      ];

  void add(String description) {
    state = [
      ...state,
      Todo(
        id: getUuid(),
        description: description,
      ),
    ];
  }

  void toggle(String id) {
    state = state.map((todo) {
      return todo.id == id
          ? Todo(
              id: todo.id,
              description: todo.description,
              completed: !todo.completed,
            )
          : todo;
    }).toList();
  }

  void edit({required String id, required String description}) {
    // final target = state.singleWhere((element) => element.id == id);
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            description: description,
            completed: todo.completed,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
