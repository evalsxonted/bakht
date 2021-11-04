
import 'package:bakht/presentation/pages/home/widgets/profile_photo.dart';
import 'package:bakht/presentation/widgets/icons/bouncing_icon.dart';
import 'package:flutter/material.dart';


class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize {
    // return new Size.fromHeight(kToolbarHeight);
    return new Size.fromHeight(200);
  }
}

class _HomeAppBarState extends State<HomeAppBar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: BouncingIcon(
            voidCallback: () {},
            size: 36,
            color: Theme.of(context).primaryColorLight,
            icon: Icons.notifications,
          ),
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).canvasColor,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ProfilePhoto(),
        ),
      ),
      toolbarHeight: 200,
    );
  }
}
