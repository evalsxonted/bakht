

import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/features/user/domain/abstractions/auth_abstraction.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;

class AuthGuest implements UseCase<Either<fa.User> , NoParams> {
  final AuthAbstraction authAbstraction;
  AuthGuest({required this.authAbstraction});

  @override
  Future<Either<fa.User>> call(NoParams params) async {
    Either<fa.User> result = await authAbstraction.registerGuestAuth();
    return result;
  }

}
