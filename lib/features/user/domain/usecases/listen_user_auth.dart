

import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/features/user/domain/abstractions/auth_abstraction.dart';

class AuthListen implements UseCase<Either<bool> , NoParams> {
  final AuthAbstraction authAbstraction;
  AuthListen({required this.authAbstraction});

  @override
  Future<Either<bool>> call(NoParams params) async {
    Either<bool> result = await authAbstraction.listenToAuthChanges();
    return result;
  }
  
}
