import 'package:flutter/material.dart';

class GamesTab extends StatefulWidget {
  const GamesTab({Key? key}) : super(key: key);

  @override
  _GamesTabState createState() => _GamesTabState();
}

class _GamesTabState extends State<GamesTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Text("games"),
       ),
    );
  }
}
