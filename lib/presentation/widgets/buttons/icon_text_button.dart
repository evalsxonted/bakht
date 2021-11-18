import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final Color backgroundColor;
  final double width;
  final VoidCallback function;
  IconTextButton({
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.width,
    required this.function
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      height: 45,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: function,
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
      ),
    );
  }
}
