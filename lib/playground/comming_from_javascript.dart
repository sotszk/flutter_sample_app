void printAll() {
  var a = 2;
  print(a == 1 + 1);
  print(identical(a, 1 + 1));

  const num b = 20.5;
  print(b.round());

  final String str; // ここではまだ初期化されていない
  const String str2 = 'at compiling time';

  if (str2.isNotEmpty) {
    str = 'str2 is not empty';
  } else {
    str = 'str2 is empty';
  }

  // str = ''; // final は一回だけしか代入できない
  print(str);

  void showNumber(int number) => print(number);

  // but not allowed bellow
  // void showNumber2(int number) => {
  //   print(number);
  // }
  showNumber(99);

  // Parameters

  // not named
  int multiply(int a, [int b = 1, int? c]) {
    return a * b * (c ?? 1);
  }

  // named
  int multiplyNamed({required int a, int b = 1, int? c}) {
    return a * b * (c ?? 1);
  }

  print(multiply(20, 10));
  print(multiplyNamed(a: 20, b: 10));

  // function as First-Class citizens
  int plusOneAndTotal(int a, int b) {
    return [
      for (var i in [a, b]) i + 1,
    ].reduce((a, b) => a + b);
  }

  print(plusOneAndTotal(20, 10));

  int plusTwoAndTotal(int a, int b) {
    return [a, b].map((i) => i + 2).reduce((a, b) => a + b);
  }

  print(plusTwoAndTotal(20, 10));

  for (final i in [2, 3]) {
    print(i);
  }

  executeCommand(Command.open);
}

// switch (https://dart.dev/language/branches#switch-statements)
enum Command { open, closed, idle }

// -> continue with label
executeCommand(Command command) {
  switch (command) {
    case Command.open:
      print('open.');
      continue finalCase;

    case Command.closed:
      print('closed');
    // break; // break statement is not required

    finalCase:
    case Command.idle:
      print('finally executed.');
  }
}

// Cascades (https://dart.dev/resources/coming-from/js-to-dart#cascades-operator)
// means (..operator)
class Animal {
  String name;
  int? age;

  Animal({required this.name, this.age});

  walk() {}
}

var me = Animal(name: 'Me')
  ..age = 20
  ..walk();

// Collection (https://dart.dev/resources/coming-from/js-to-dart#collections)
