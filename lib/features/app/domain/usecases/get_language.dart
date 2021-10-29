
import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/features/app/domain/abstractions/prefs_abstraction.dart';
import 'package:bakht/presentation/translation/language.dart';

class GetLanguage implements UseCase<Either<Language>, NoParams> {
  final PrefsAbstraction prefsAbstraction;
  GetLanguage({required this.prefsAbstraction});

  @override
  Future<Either<Language>> call(NoParams noParams)async{
    return await prefsAbstraction.getLanguage();
  }
}


