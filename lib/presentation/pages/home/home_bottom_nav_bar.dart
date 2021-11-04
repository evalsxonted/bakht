import 'package:bakht/presentation/pages/home/controllers/tabs_controller.dart';
import 'package:bakht/presentation/pages/home/widgets/bottom_bar_games_icon.dart';
import 'package:bakht/presentation/pages/home/widgets/bottom_bar_home_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/bottom_bar_cart_icon.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      spreadRadius: 3,
                      blurRadius: 1),
                  BoxShadow(
                      color: Theme.of(context).backgroundColor,
                      spreadRadius: 3,
                      blurRadius: 1),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Consumer<TabsController>(
                builder: (context, TabsController tabsController, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: AnimatedGamesIcon(
                          startColor: Theme.of(context).hintColor,
                          endColor: Theme.of(context).primaryColorLight,
                          size: Size(36, 36),
                          index: 0,
                          tabsController: tabsController,
                          fixedColor: Theme.of(context).canvasColor,
                        ),
                      ),
                      Container(
                        child: AnimatedHomeIcon(
                          startColor: Theme.of(context).hintColor,
                          endColor: Theme.of(context).primaryColorLight,
                          size: Size(36, 36),
                          index: 1,
                          tabsController: tabsController,
                          fixedColor: Theme.of(context).canvasColor,
                        ),
                      ),
                      Container(
                        child: AnimatedCartIcon(
                          startColor: Theme.of(context).hintColor,
                          endColor: Theme.of(context).primaryColorLight,
                          size: Size(36, 36),
                          index: 2,
                          tabsController: tabsController,
                          fixedColor: Theme.of(context).canvasColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
