import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:go_router/go_router.dart';
import '../models/todo.dart';

final addTodoKey = UniqueKey();
final allFilterKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();

final todoListProvider = NotifierProvider<TodoList, List<Todo>>(TodoList.new);

enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListFilter = StateProvider((_) => TodoListFilter.all);

final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});

class TodoPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    final newTodoController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          const Title(),
          TextField(
            key: addTodoKey,
            controller: newTodoController,
            decoration: const InputDecoration(
              labelText: 'なにをしたい？',
            ),
            onSubmitted: (value) {
              final todoList = ref.read(todoListProvider.notifier);
              todoList.add(value);
              newTodoController.clear();
            },
          ),
          SizedBox(height: 42),
          const Toolbar(),
          if (todos.isNotEmpty) const Divider(height: 0),
          for (var i = 0; i < todos.length; i++) ...[
            if (i > 0) const Divider(height: 0),
            Dismissible(
              key: ValueKey(todos[i].id),
              child: ProviderScope(
                overrides: [_currentTodo.overrideWithValue(todos[i])],
                child: const TodoItem(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class Toolbar extends HookConsumerWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${ref.watch(uncompletedTodosCount)} items left',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: allFilterKey,
            message: 'All todos',
            child: TextButton(
              onPressed: () =>
                  ref.read(todoListFilter.notifier).state = TodoListFilter.all,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                    WidgetStatePropertyAll(textColorFor(TodoListFilter.all)),
              ),
              child: const Text('All'),
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Only uncompleted todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.active,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                    WidgetStatePropertyAll(textColorFor(TodoListFilter.active)),
              ),
              child: const Text('Active'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Only completed todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: WidgetStatePropertyAll(
                  textColorFor(TodoListFilter.completed),
                ),
              ),
              child: const Text('Completed'),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'todos',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(38, 47, 47, 247),
        fontSize: 100,
        fontWeight: FontWeight.w100,
        fontFamily: 'Helvetica Neue',
      ),
    );
  }
}

final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

// TODO: implement this
class TodoItem extends HookConsumerWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(_currentTodo);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.description),
        ],
      ),
    );
  }
}

// カスタムフック
bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(() {
    void listener() {
      isFocused.value = node.hasFocus;
    }

    node.addListener(listener);
    return () => node.removeListener(listener);
  });

  return isFocused.value;
}
