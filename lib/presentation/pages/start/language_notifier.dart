
import 'package:bakht/presentation/translation/language.dart';
import 'package:flutter/material.dart';

class LanguageNotifier extends ChangeNotifier{
  Language? _language;

  Language? get language => _language ;

  Future<LanguageNotifier> initLanguage() async{
    // _language = English();
    //no notify listener
    return this;
  }
  switchToArabic(){
    notifyListeners();
  }
  switchToEnglish(){
    notifyListeners();
  }
}