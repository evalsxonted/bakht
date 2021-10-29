import 'package:bakht/core/either/either.dart';
import 'package:bakht/presentation/translation/language.dart';
import 'package:flutter/material.dart';

abstract class PrefsAbstraction {
  Future<Either<Language>> getLanguage();
  Future<Either<ThemeMode>> getTheme();

}