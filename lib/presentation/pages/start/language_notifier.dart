
import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/handle_failure.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/core/usecase/usecases_caller.dart';
import 'package:bakht/features/app/domain/usecases/get_language.dart';
import 'package:bakht/presentation/translation/language.dart';
import 'package:flutter/material.dart';

class LanguageNotifier extends ChangeNotifier{
  late Language _language;
  final UseCaseCaller useCaseCaller;
  LanguageNotifier({required this.useCaseCaller});
  Language get language => _language ;

  Future<LanguageNotifier> initLanguage() async{
    GetLanguage getLanguage = useCaseCaller.getLanguage();
   Either<Language> either = await getLanguage(NoParams());
   if(either.isFailed){
     HandleFailure(either.left!).saveToLocalLog();
     HandleFailure(either.left!).showErrorPage();
   }else{
     _language = either.right!;
   }
    return this;
  }
  switchToArabic(){
    notifyListeners();
  }
  switchToEnglish(){
    notifyListeners();
  }
}