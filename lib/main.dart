import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_example_app/src/screens/todo.dart';
import 'src/screens/home.dart';
import 'src/screens/album.dart';
import 'src/util/dio.dart';

void main() {
  configureDio();

  runApp(
    ProviderScope(child: MyApp()),
  );
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavigation(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return HomePage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'todo',
              builder: (BuildContext context, GoRouterState state) {
                return TodoPage();
              },
            ),
            GoRoute(
              path: 'albums',
              builder: (context, state) {
                return AlbumPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends HookConsumerWidget {
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
    );
  }
}

class ScaffoldWithNavigation extends ConsumerWidget {
  ScaffoldWithNavigation({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Awesome App',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: child,
    );
  }
}
