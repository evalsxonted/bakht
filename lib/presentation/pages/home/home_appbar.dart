import 'package:bakht/presentation/pages/home/controllers/tabs_controller.dart';
import 'package:bakht/presentation/pages/home/widgets/balance_gold.dart';
import 'package:bakht/presentation/pages/home/widgets/balance_silver.dart';
import 'package:bakht/presentation/pages/home/widgets/edit_profile_text.dart';
import 'package:bakht/presentation/pages/home/widgets/profile_photo.dart';
import 'package:bakht/presentation/pages/start/user_notifier.dart';
import 'package:bakht/presentation/widgets/icons/bouncing_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/balance_bronze.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize {
    return new Size.fromHeight(200);
  }
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<TabsController, UserNotifier>(
      builder: (context, tabsController, userNotifier, child) {
        double flexibleSpaceHeight = tabsController.tabIndex == 1 ? 200 : 80;
        double profileOpacity = tabsController.tabIndex == 1 ? 1 : 0;
        return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: BouncingIcon(
                voidCallback: () {},
                size: 36,
                color: Theme.of(context).primaryColorLight,
                icon: Icons.notifications,
              ),
            ),
          ],
          flexibleSpace: AnimatedContainer(
            height: flexibleSpaceHeight,
            duration: Duration(seconds: 1),
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
                bottomRight: Radius.circular(50),
              ),
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: profileOpacity,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ProfilePhoto(),
                          Positioned(
                            bottom: 0,
                            child: EditProfile(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            AnimatedPositioned(
                              duration: Duration(seconds: 1),
                              height: 40,
                              top: 20,
                              child: BalanceGold(
                                balanceGold:
                                    userNotifier.user?.balanceGold ?? 0,
                              ),
                            ),
                            Positioned(
                              height: 40,
                              child: BalanceSilver(
                                  balanceSilver:
                                      userNotifier.user?.balanceSilver ?? 0),
                            ),
                            AnimatedPositioned(
                              duration: Duration(seconds: 1),
                              bottom: 20,
                              height: 40,
                              child: BalanceBronze(
                                  balanceBronze:
                                      userNotifier.user?.balanceBronze ?? 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          // toolbarHeight: 200,
        );
      },
    );
  }
}
