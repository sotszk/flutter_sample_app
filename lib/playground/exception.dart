void init() {
  // Error と Exception

  // Error
  // プログラミング上の構文上のエラーや間違った引数を渡している場合など
  // 呼び出し元で補足する必要はない

  // Exception
  // 呼び出し元で補足されることを目的としたエラー
  // Exception には、エラーに関する情報が持たせるべき

  try {
    throwException();
  } on Exception catch (err, st) {
    print('catch exception');
    print('errMessage=$err');
    print('stackTrace=$st');
  }
}

void throwException() {
  throw Exception('絶対に例外が投げられる！');
}
