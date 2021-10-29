import 'package:bakht/presentation/pages/error/error_smile.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String messageToShow;

  const ErrorPage({Key? key, required this.messageToShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Scaffold(
            backgroundColor: Color(0xff313660),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ErrorSmile(),
                Text(
                  messageToShow,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Container(
                  width: double.infinity,
                )
              ],
            )),
      ),
    );
  }
}

void showErrorPage(String message) {
  runApp(ErrorPage(
    messageToShow: message,
  ));
}
