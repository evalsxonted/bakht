import 'package:flutter/material.dart';

class IconTextCard extends StatelessWidget {
  final String text;
  final Widget icon;
  final Color backgroundColor;
  final double width;
  IconTextCard({
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 35,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(text, style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).highlightColor
              ),),
            ),
          ),
          icon,
        ],
      ),
    );
  }
}
