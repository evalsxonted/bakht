import 'package:bakht/presentation/pages/home/appbar.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ThemeData theme;
  late double width;
  late double height;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),

      bottomNavigationBar: Container(
        child: Text("data"),
      ),
    );
  }
}

