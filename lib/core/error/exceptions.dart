// class MyException implements Exception{
//
// }
class ModelingException implements Exception {
  final String? message;

  ModelingException([this.message]);
}

class DocumentNotFoundException implements Exception {
  final String? message;

  DocumentNotFoundException([this.message]);
}

class UnknownException implements Exception {
  final String? message;

  UnknownException([this.message]);
}

class HiveNotFoundException implements Exception {
  final String? message;

  HiveNotFoundException([this.message]);
}

// error codes counter 1
// error codes counter 2
// error codes counter 3
// error codes counter 4
// error codes counter 5
// error codes counter 6
// error codes counter 7
// error codes counter
