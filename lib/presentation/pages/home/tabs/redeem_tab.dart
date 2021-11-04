import 'package:flutter/material.dart';

class RedeemTab extends StatefulWidget {
  const RedeemTab({Key? key}) : super(key: key);

  @override
  _RedeemTabState createState() => _RedeemTabState();
}

class _RedeemTabState extends State<RedeemTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("redeem"),
      ),
    );
  }
}
