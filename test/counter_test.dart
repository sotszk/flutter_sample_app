import 'package:riverpod_example_app/src/counter.dart';
import 'package:test/test.dart';

void main() {
  test('カウターがインクリメントされていること', () {
    final counter = Counter(value: 1);

    counter.increment();

    expect(counter.value, 2);
  });

  group('Test start, increment, decrement', () {
    test('init', () {
      expect(Counter().value, 0);
    });

    test('value should be decremented', () {
      final counter = Counter(value: 1);

      counter.decrement();

      expect(counter.value, 0);
    });
  });
}
