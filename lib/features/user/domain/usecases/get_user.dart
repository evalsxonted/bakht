
import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/features/user/domain/abstractions/user_abstraction.dart';
import 'package:bakht/features/user/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;

class GetUser implements UseCase<Either<User>, fa.User> {
  final UserAbstraction userAbstraction;
  GetUser({required this.userAbstraction});

  @override
  Future<Either<User>> call(fa.User faUser)async{
    Either<User> result = Either(null, null);
    result = await userAbstraction.getUser(faUser);
    return result;
  }
}


