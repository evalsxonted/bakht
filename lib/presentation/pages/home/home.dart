import 'package:bakht/presentation/pages/home/home_appbar.dart';
import 'package:bakht/presentation/pages/home/controllers/tabs_controller.dart';
import 'package:bakht/presentation/pages/home/home_bottom_nav_bar.dart';
import 'package:bakht/presentation/pages/home/tabs/games_tab.dart';
import 'package:bakht/presentation/pages/home/tabs/home_tab.dart';
import 'package:bakht/presentation/pages/home/tabs/redeem_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TabsController tabsController;

  @override
  void initState() {
    tabsController = TabsController();
    super.initState();
  }

  @override
  void dispose() {
    tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).backgroundColor,
            ],
            tileMode: TileMode.repeated,
            end: Alignment.bottomLeft,
            begin: Alignment.topRight),
      ),
      child: ChangeNotifierProvider(
        create: (context) => tabsController,
        builder: (context, child) => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: HomeAppBar(),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabsController.pageController,
            children: [
              GamesTab(),
              HomeTab(),
              RedeemTab(),
            ],
          ),
          bottomNavigationBar: BottomNavBar(),
        ),
      ),
    );
  }
}
