import 'package:bakht/core/error/failure.dart';

class Either<R>{
  Failure? left;
  R? right;
  bool get isFailed => left !=null;
  bool get isValid => right !=null;
  Either(this.left, this.right);
}