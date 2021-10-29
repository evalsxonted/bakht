import 'package:bakht/core/error/failure.dart';

class Either<R>{
  Failure? left;
  R? right;
  bool get isFailed => left !=null;
  Either(this.left, this.right);
}