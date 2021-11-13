import 'package:bakht/presentation/pages/profile/profile.dart';
import 'package:bakht/presentation/widgets/clickables/clickable_text.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor.withAlpha(255),
      padding: EdgeInsets.only(left: 30, right: 30),
      child: ClickableText(
        text: "edit profile",
        function: () {
          Navigator.of(context).push(_createRoute());
        },
        color: Theme.of(context).highlightColor,
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => const Profile(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,

      );
    },
  );
}
