import 'package:bakht/presentation/pages/home/profile_photo.dart';
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

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool menuClicked = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
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

      flexibleSpace: Padding(
        padding:  EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ProfilePhoto(),
        ),
      ),
      toolbarHeight: 200,
    );
  }
}
