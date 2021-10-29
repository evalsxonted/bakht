
import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/features/app/domain/abstractions/prefs_abstraction.dart';
import 'package:flutter/material.dart';

class GetTheme implements UseCase<Either<ThemeMode>, NoParams> {
  final PrefsAbstraction prefsAbstraction;
  GetTheme({required this.prefsAbstraction});

  @override
  Future<Either<ThemeMode>> call(NoParams noParams)async{
    return await prefsAbstraction.getTheme();
  }
}


