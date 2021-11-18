import 'package:bakht/presentation/widgets/cards/icon_text_card.dart';
import 'package:flutter/material.dart';

class BalanceSilver extends StatelessWidget {
  final double balanceSilver;
  BalanceSilver({Key? key,required this.balanceSilver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTextCard(
      width: 120,
      backgroundColor: Theme.of(context).cardColor,
      icon: Text("S", style: TextStyle(
          color: Color(0xffC0C0C0),
          fontWeight: FontWeight.w800,
          fontSize: 19
      ),),
      text: balanceSilver.toString(),
    );
  }
}
