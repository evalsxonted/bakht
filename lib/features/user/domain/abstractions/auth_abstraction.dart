
import 'package:bakht/core/either/either.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;

abstract class AuthAbstraction{
  Future<Either<fa.User>> registerGuestAuth();
  Future<Either<fa.User>> registerPhoneAuth();
  Future<Either<bool>> listenToAuthChanges();
  Future<Either<bool>> signOut();
  // Future<Either<bool>> updateUser(User user);
}