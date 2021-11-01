


import 'dart:io';

import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/features/user/domain/abstractions/user_abstraction.dart';

class GetProfilePhoto implements UseCase<Either<File> , NoParams>{
  final UserAbstraction userAbstraction;
  GetProfilePhoto({required this.userAbstraction});

  @override
  Future<Either<File>> call(NoParams params) async {
    return await userAbstraction.getProfilePhoto();
  }

}