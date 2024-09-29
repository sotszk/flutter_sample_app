void controlInArray() {
  const List<int> list = [20, 10, 0];
  final listReversed = [...list.reversed];
  final listDouble = [for (var i in list) i * 2];
  final listAdded = [...list, if (list.length == 3) 100];
}
