import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import '../util/dio.dart';
import '../models/album.dart';

part 'album.g.dart';

@riverpod
Future<Album> album(AlbumRef ref) async {
  final response =
      await dio.get('https://jsonplaceholder.typicode.com/albums/1');
  if (response.statusCode == 200) {
    return Album.fromJson(response.data as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load albums');
  }
}

class AlbumPage extends HookConsumerWidget {
  @override
  Widget build(context, ref) {
    final count = useState(0);

    useEffect(
      () {
        print('Album page init');
        return () {
          print('Album page disposed');
        };
      },
      const [],
    );

    final AsyncValue<Album> album = ref.watch(albumProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          switch (album) {
            AsyncData(:final value) => Text('album: ${value.title}'),
            AsyncError() => const Text('Oops something unexpected happened'),
            AsyncValue<Album>() => Text('Loading...'),
          },
          Text('count: ${count.value}'),
          ElevatedButton.icon(
            onPressed: () => count.value++,
            icon: Icon(Icons.add),
            label: Text('increment'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: Text('Go Home'),
          ),
        ],
      ),
    );
  }
}
