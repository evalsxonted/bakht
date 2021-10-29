import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/handle_failure.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/core/usecase/usecases_caller.dart';
import 'package:bakht/features/app/domain/usecases/get_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier{
  late ThemeMode _themeMode;
  final UseCaseCaller useCaseCaller;
  ThemeNotifier({required this.useCaseCaller});
  ThemeMode get themeMode => _themeMode;


  Future<ThemeNotifier> initTheme() async {
    GetTheme getTheme = useCaseCaller.getTheme();
    Either<ThemeMode> either = await getTheme(NoParams());
    if(either.isFailed){
      HandleFailure(either.left!).saveToLocalLog();
      HandleFailure(either.left!).showErrorPage();
    }else{
      _themeMode = either.right!;
    }
    return this;
  }

  switchToDark(){
    notifyListeners();
  }
  switchToLight(){
    notifyListeners();
  }
}