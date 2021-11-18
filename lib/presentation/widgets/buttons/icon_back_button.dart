import 'package:flutter/material.dart';

class IconBack extends StatefulWidget {
  @override
  _IconBackState createState() => _IconBackState();
}

class _IconBackState extends State<IconBack> {
  double iconAnimatedPadding = 10;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsetsDirectional.only(start: iconAnimatedPadding),
      duration: Duration(milliseconds: 500),
      child: IconButton(
        onPressed: () {
          setState(() {
            iconAnimatedPadding = 0;
            Future.delayed(Duration(milliseconds: 450),
                (){
                  Navigator.of(context).pop();
                  iconAnimatedPadding = 10;
                }
            );
          });
        },
        icon: Icon(Icons.arrow_back,
          color: Theme.of(context).highlightColor,
          size: 35,
        ),
      ),
    );
  }
}
