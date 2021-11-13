import 'package:flutter/material.dart';


class ClickableText extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final Color color;
  const ClickableText({Key? key,required this.text,required this.function, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Text(text, style: TextStyle(
        fontSize: 16,
        color: color,
        decorationStyle: TextDecorationStyle.solid,
        decoration: TextDecoration.underline,
        decorationColor: color
      ),),
    );
  }
}
