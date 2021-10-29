
class ModelingException implements Exception {
  final String? message;

  ModelingException([this.message]);
  @override
  String toString() {
    return message?? "";
  }
}

class DocumentNotFoundException implements Exception {
  final String? message;

  DocumentNotFoundException([this.message]);
  @override
  String toString() {
    return message?? "";
  }
}

class UnknownException implements Exception {
  final String? message;

  UnknownException([this.message]);
  @override
  String toString() {
    return message?? "";
  }
}

class HiveNotFoundException implements Exception {
  final String? message;

  HiveNotFoundException([this.message]);
  @override
  String toString() {
    return message?? "";
  }
}

// error codes counter 1
// error codes counter 2
// error codes counter 3
// error codes counter 4
// error codes counter 5
// error codes counter 6
// error codes counter 7
// error codes counter 8
// error codes counter 9
// error codes counter 10
// error codes counter 11
// error codes counter 12
// error codes counter 13
// error codes counter 14
// error codes counter 15
// error codes counter
