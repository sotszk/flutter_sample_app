import 'spacecraft.dart' deferred as space; // lazy load package, for Web app
import 'planet_enum.dart' show Planet; // hide は show とは逆に除外するために使う

Future<void> printAll() async {
  helloWorld();

  await loadSpace();

  var voyager3 = space.Spacecraft.unlaunched('Voyager3');
  voyager3.describe();

  const yourPlanet = Planet.mercury;
  if (!yourPlanet.isGiant) {
    print('Your planet is not giant');
  }

  name = 20;
  print('name: $name');

  description = 'Dart is a language with Null-safety features';
  print('description $description'); // description に代入しなかった場合は実行時にエラーとなる

  bottles = [1, 20, 300];
  print('bottles[0] ${bottles[0]}');
  print(
    'bottles.takeWhile: ${bottles.takeWhile((value) => value < 100)}',
  ); // 条件が false になるまで回す

  print('map: $map');
  print('set: $set');
  // mapObject['id'] = 'zero'; // const の場合 Cannot modify unmodifiable map Exception
  print('mapObject.keys: ${mapObject.keys}');
  print('mapObject["name"]: ${mapObject["name"]}');

  mapObjectB['id'] = 'one';
  print('mapObjectB["id"] ${mapObjectB["id"]}');

  print('${20 ~/ 3}'); // あまりを切り捨てる

  assert(mapObjectB['name'] == null);
  print('finish.');
}

Future<void> loadSpace() async {
  await space.loadLibrary();
}

// const hello = 'こんにちは, 世界';
const String hello = 'Hello world!';

@Deprecated('deprecated')
void helloWorld() {
  print(hello);
}

// Object name = 'Me';
dynamic name = 'Me';

late String description;

/// あなたが今日飲んだペットボトル
var bottles = const <int>[]; // 再代入可能

const Object i = 10;
const list = [i as int, 20, 30, 40];

// Map
const map = {
  if (i is int) i: 'int',
  if (i is String) i: 'String',
};

// Set
const set = {
  ...list,
  50,
  60,
};

const mapObject = {
  'name': 'patagonia',
  'price': 1000,
};
var mapObjectB = <String, String>{
  'name': 'monbel',
}; // Map() と同じ
