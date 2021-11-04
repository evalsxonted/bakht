import 'package:flutter/cupertino.dart';

class TabsController extends ChangeNotifier{
  late int tabIndex;
  late PageController pageController;
  TabsController(){
    tabIndex = 1;
    pageController = PageController(initialPage: 1);
  }

  changeTab(int index){
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
    tabIndex = index;
    notifyListeners();
  }
  @override
  void dispose() {
    pageController.dispose();
     super.dispose();
  }


}