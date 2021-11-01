import 'dart:io';

import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/exceptions.dart';
import 'package:bakht/core/error/failure.dart';
import 'package:bakht/features/app/data/datasources/prefs_local_datasource.dart';
import 'package:bakht/features/app/domain/abstractions/prefs_abstraction.dart';
import 'package:bakht/presentation/translation/english.dart';
import 'package:bakht/presentation/translation/language.dart';
import 'package:flutter/material.dart';

class PrefsImpl implements PrefsAbstraction {
  final PrefsLocalDatasource prefsLocalDatasource;
  Map<String, Language> languages = {
    "en": English(),
  };
  Map<String, ThemeMode> themes = {
    "dark" : ThemeMode.dark,
    "light" : ThemeMode.light,
  };
  PrefsImpl({required this.prefsLocalDatasource});

  @override
  Future<Either<Language>> getLanguage() async {
    Either<Language> result = Either(null, null);
    late String language; // default
    try {
      language = await prefsLocalDatasource.getFromPrefs("language");
    } on NotFoundException {
      language = Platform.localeName.split('_')[0];
    } catch (e) {
      result.left = Failure(
          "error getting language, if this error keeps showing please contact the app developer, error code 14",
          e.toString());
      return result;
    }
    result.right = languages[language] ?? English();
    return result;
  }

  @override
  Future<Either<ThemeMode>> getTheme() async {
    Either<ThemeMode> result = Either(null, null);
    late String theme;

    try {
      theme = await prefsLocalDatasource.getFromPrefs("theme");
    } on NotFoundException {
      result.right = ThemeMode.system;
      return result;
    } catch (e) {
      result.left = Failure(
          "error getting language, if this error keeps showing please contact the app developer, error code 15",
          e.toString());
      return result;
    }
    result.right = themes[theme] ?? ThemeMode.system;
    return result;

  }
}
