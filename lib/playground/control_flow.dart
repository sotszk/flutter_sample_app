void controlInArray() {
  const List<int> list = [20, 10, 0];
  final listReversed = [...list.reversed];
  final listDouble = [for (var i in list) i * 2];
  final listAdded = [...list, if (list.length == 3) 100];
}

void switchExpression() {
  const int status = 0;

  final statusText = switch (status) {
    == null => 'No Status',
    >= 500 => 'Server error',
    >= 400 => 'Client error',
    >= 200 => 'Success',
    _ => throw FormatException()
  };

  print('status=$status, statusText=$statusText');
}
