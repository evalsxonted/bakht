import 'package:bakht/presentation/pages/start/start.dart';
import 'package:flutter/material.dart';
import 'presentation/widgets/buttons/icon_text_button.dart';

void main()  {
  runApp(Start());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body: Center(
        child: IconTextButton(
          width: 100,
          backgroundColor: Colors.teal,
          icon: Text("G", style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.w800,
            fontSize: 19
          ),),
          text: "gold coins",
        ),
      ),
    ),);
  }
}
