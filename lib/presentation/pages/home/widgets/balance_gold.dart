import 'package:bakht/presentation/widgets/cards/icon_text_card.dart';
import 'package:flutter/material.dart';

class BalanceGold extends StatelessWidget {
  final double balanceGold;
  BalanceGold({Key? key,required this.balanceGold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTextCard(
      width: 120,
      backgroundColor: Theme.of(context).cardColor,
      icon: Text("G", style: TextStyle(
          color: Colors.yellow,
          fontWeight: FontWeight.w800,
          fontSize: 19
      ),),
      text: balanceGold.toString(),
    );
  }
}
