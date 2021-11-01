
import 'dart:io';

import 'package:bakht/core/either/either.dart';
import 'package:bakht/features/user/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;

abstract class UserAbstraction{
  Future<Either<User>> getUser(fa.User faUser);
  Future<Either<User>> addNewGuestUser(fa.User faUser);
  Future<Either<bool>> updateUser(User user);
  Future<Either<File>> getProfilePhoto();
  Future<Either<bool>> saveProfilePhoto(File file);

}