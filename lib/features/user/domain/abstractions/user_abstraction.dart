
import 'package:bakht/core/either/either.dart';
import 'package:bakht/features/user/domain/entities/user.dart';

abstract class UserAbstraction{
  Future<Either<User>> getUser();
  Future<Either<User>> addNewGuestUser();
  Future<Either<bool>> updateUser(User user);
}