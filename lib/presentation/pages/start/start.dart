import 'dart:io';

import 'package:bakht/presentation/pages/home/home.dart';
import 'package:bakht/presentation/pages/splash/splash.dart';
import 'package:bakht/presentation/pages/start/user_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'language_notifier.dart';
import 'theme_notifier.dart';
import 'package:path_provider/path_provider.dart';

class Start extends StatelessWidget {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initApp(),
      initialData: null,
      builder: (context, AsyncSnapshot<List?> snapshot) {
        List? values = snapshot.data;
        if (snapshot.hasData &&
            values?[0] != null &&
            values?[1] != null &&
            values?[2] != null) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<LanguageNotifier>(
                    create: (context) => values?[0]),
                ChangeNotifierProvider<ThemeNotifier>(
                    create: (context) => values?[1]),
                ChangeNotifierProvider<UserNotifier>(
                    create: (context) => values?[2]),
                Provider<FirebaseFirestore>(
                  create: (context) => values?[3],
                )
              ],
              child: Consumer2<LanguageNotifier, ThemeNotifier>(
                builder: (context, languageNotifier, themeNotifier, child) {
                  return Directionality(
                    textDirection: TextDirection.ltr, //todo
                    child: MaterialApp(
                      theme: themeNotifier.themeData,
                      home: Home(),
                    ),
                  );
                },
              ));
        } else {
          return MaterialApp(
            home: Splash(),
          );
        }
      },
    );
  }

  Future<List> initApp() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return await Future.wait([
      LanguageNotifier().initLanguage(),
      ThemeNotifier().initTheme(),
      UserNotifier().initUser(firestore),
      Future.value(firestore),
      //
      Future.delayed(Duration(seconds: 5)),
    ]);
  }
}
