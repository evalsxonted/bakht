

import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/features/user/domain/abstractions/user_abstraction.dart';

class SaveProfilePhoto implements UseCase<Either<bool> , NoParams>{
  final UserAbstraction userAbstraction;
  SaveProfilePhoto({required this.userAbstraction});

  @override
  Future<Either<bool>> call(NoParams noParams) async {
    return await userAbstraction.saveProfilePhoto();
  }

}