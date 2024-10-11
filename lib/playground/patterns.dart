void init() {
  // 分解宣言（JS の分割代入とほぼ同じ）
  const (String? message, int? status) response = ('OK', 200);
  final (message, status) = response;
  print('message=$message, status=$status');

  // その2 List の場合
  final List<int> nums = [1, 2, 3, 4, 5];
  final [$1, $2, ..., $4, $5] = nums;
  print('${$1}, ${$2}, ${$4}, ${$5}');

  // その3 Record (タプル)の場合
  const rec = (name: 'Hey', id: 1);
  final (name: n, id: i) = rec;
  print('name=$n, id=$i');

  // その4 クラス
  final cat = Animal(name: 'ちゃむ');
  final Animal(name: catName) = cat;
  print('catName=$catName');

  switch (cat) {
    case Animal():
      print('猫はどうぶつ');
    // case String():
    //   print('猫は文字列');
  }

  // null asserting
  // case (final i!)

  // null check
  // case (final i?)

  // _ はワイルドカード
}

class Animal {
  final String name;
  const Animal({required this.name});
}
