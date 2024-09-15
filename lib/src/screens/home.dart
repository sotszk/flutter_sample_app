import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'home.g.dart';

@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello, World!';
}

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state--;
}

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int count = ref.watch(counterProvider);
    final String value = ref.watch(helloWorldProvider);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value $count',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/todo'),
              child: Text('Go Todo'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/albums'),
              child: Text('Go Albums'),
            ),
            SizedBox(height: 8),
            FloatingActionButton(
              onPressed: () => ref.read(counterProvider.notifier).increment(),
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
