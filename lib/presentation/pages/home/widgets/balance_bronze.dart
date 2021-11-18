


import 'package:bakht/presentation/widgets/cards/icon_text_card.dart';
import 'package:flutter/material.dart';

class BalanceBronze extends StatelessWidget {
  final double balanceBronze;
  BalanceBronze({Key? key,required this.balanceBronze}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTextCard(
      width: 120,
      backgroundColor: Theme.of(context).cardColor,
      icon: Text("B", style: TextStyle(
          color: Color(0xffCD7F32),
          fontWeight: FontWeight.w800,
          fontSize: 19
      ),),
      text: balanceBronze.toString(),
    );
  }
}
