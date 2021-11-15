import 'package:bakht/presentation/routes/home_to_profile.dart';
import 'package:bakht/presentation/widgets/clickables/clickable_text.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  final HomeToProfileRoute route = HomeToProfileRoute();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor.withAlpha(255),
      padding: EdgeInsets.only(left: 30, right: 30),
      child: ClickableText(
        key: route.widgetKey,
        text: "edit profile",
        function: () {
          Navigator.of(context).push(route());
        },
        color: Theme.of(context).highlightColor,
      ),
    );
  }
}
