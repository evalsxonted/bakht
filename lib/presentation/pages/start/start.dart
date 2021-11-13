import 'dart:io';
import 'package:bakht/core/usecase/usecases_caller.dart';
import 'package:bakht/presentation/pages/home/home.dart';
import 'package:bakht/presentation/pages/splash/splash.dart';
import 'package:bakht/presentation/pages/start/user_notifier.dart';
import 'package:bakht/presentation/theme/theme_handler.dart';
import 'package:bakht/presentation/translation/english.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'language_notifier.dart';
import 'theme_notifier.dart';
import 'package:path_provider/path_provider.dart';

class Start extends StatelessWidget {
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
            values?[2] != null &&
            values?[3] != null &&
            values?[4] != null) {
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
              ),
              Provider<FirebaseAuth>(
                create: (context) => values?[4],
              ),
              Provider<UseCaseCaller>(
                create: (context) => values?[5],
              )
            ],
            child: Builder(
              builder: (context) => Consumer2<LanguageNotifier, ThemeNotifier>(
                builder: (context, languageNotifier, themeNotifier, child) {
                  return Directionality(
                    textDirection:
                        languageNotifier.language.appName == English().appName
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      themeMode: themeNotifier.themeMode,
                      darkTheme: ThemeHandler().darkTheme,
                      theme: ThemeHandler().darkTheme,
                      home: Home(),
                    ),
                  );
                },
              ),
            ),
          );
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
    FirebaseAuth auth = FirebaseAuth.instance;
    UseCaseCaller useCaseCaller = UseCaseCaller(firebaseFirestore: firestore, firebaseAuth: auth);
    Paint.enableDithering = true;

    return await Future.wait([
      LanguageNotifier(useCaseCaller: useCaseCaller).initLanguage(),
      ThemeNotifier(useCaseCaller: useCaseCaller).initTheme(),
      UserNotifier().initUser(auth, useCaseCaller),
      Future.value(firestore),
      Future.value(auth),
      Future.value(useCaseCaller),
      //
      Future.delayed(Duration(seconds: 4)),
    ]);
  }
}
