
import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/features/user/domain/abstractions/user_abstraction.dart';
import 'package:bakht/features/user/domain/entities/user.dart';

class GetUser implements UseCase<Either<User>, NoParams> {
  final UserAbstraction userAbstraction;
  GetUser({required this.userAbstraction});

  @override
  Future<Either<User>> call(NoParams noParams)async{
    Either<User> result = Either(null, null);
    result = await userAbstraction.getUser();
    return result;
  }
}