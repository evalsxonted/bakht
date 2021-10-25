import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late double height;
  late double width;
  late double afterLeft;
  late double afterRight;
  double afterTop = 1;
  double afterBottom = 1;
  double iconWidth = 100;
  double iconHeight = 100;
  bool animate = false;
    @override
  void initState() {
      runAnimate();
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    afterLeft = (width * 0.5) - (iconWidth / 2);
    afterRight = (width * 0.5) - (iconWidth / 2);
    return Scaffold(
      backgroundColor: Color(0xff313660),
      appBar: null,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              key: Key("6"),
              curve: Curves.ease,
              duration: Duration(seconds: 2),
              top: animate ? height * 0.5  :height - 130,
              height: 100,
              left: animate ? afterLeft :1,
              right: animate ? afterRight : width * 0.5+ 50,
              child: Image.asset(
                "assets/icons/logo/logo1.png",
                height: iconHeight,
                width: iconWidth,
              ),
            ),
            AnimatedPositioned(
              key: Key("8"),
              curve: Curves.ease,
              duration: Duration(seconds: 2),
              height: 100,
              top: animate ? height * 0.5  :height - 130,
              right:animate ? afterRight : 1,
              left: animate ? afterLeft : width * 0.5+ 50,
              child: Image.asset(
                "assets/icons/logo/logo1.png",
                height: iconHeight,
                width: iconWidth,
              ),
            ),
            AnimatedPositioned(
              key: Key("1"),
              curve: Curves.ease,
              duration: Duration(seconds: 2),
              bottom: animate ? height * 0.5 - 100 :height - 130,
              height: 100,
              left:animate ? afterLeft : 1,
              right: animate ? afterRight :width * 0.5+ 50,
              child: Image.asset(
                "assets/icons/logo/logo1.png",
                height: iconHeight,
                width: iconWidth,
              ),
            ),
            AnimatedPositioned(
              key: Key("3"),
              curve: Curves.ease,
              duration: Duration(seconds: 2),
              bottom: animate ? height * 0.5 - 100 :height - 130,
              height: 100,
              right:animate ? afterRight : 1,
              left: animate ? afterLeft :width * 0.5 + 50,
              child: Image.asset(
                "assets/icons/logo/logo1.png",
                height: iconHeight,
                width: iconWidth,
              ),
            ),
            AnimatedPositioned(
              key: Key("7"),
              curve: Curves.ease,
              duration: Duration(seconds: 2),
              top: animate ? height * 0.5   :height - 130,
              height: 100,
              left: animate ? afterLeft :1,
              right: animate ? afterRight : 1,
              child: Image.asset(
                "assets/icons/logo/logo1.png",
                height: iconHeight,
                width: iconWidth,
              ),
            ),
            AnimatedPositioned(
              key: Key("2"),
              curve: Curves.ease,
              duration: Duration(seconds: 2),
              bottom: animate ? height * 0.5 - 100  :height - 130,
              height: 100,
              left: animate ? afterLeft :1,
              right: animate ? afterRight : 1,
              child: Image.asset(
                "assets/icons/logo/logo1.png",
                height: iconHeight,
                width: iconWidth,
              ),
            ),
            AnimatedPositioned(
              key: Key("5"),
              curve: Curves.ease,
              duration: Duration(seconds: 2),
              top: animate ? height * 0.5   : height * 0.5 - 50,
              height: 100,
              left: animate ? afterLeft :width * 0.5 + 50,
              right: animate ? afterRight : 1,
              child: Image.asset(
                "assets/icons/logo/logo1.png",
                height: iconHeight,
                width: iconWidth,
              ),
            ),
            AnimatedPositioned(
              key: Key("4"),
              curve: Curves.ease,
              duration: Duration(seconds: 2),
              top: animate ? height * 0.5   : height * 0.5 - 50,
              height: 100,
              left: animate ? afterLeft : 1,
              right: animate ? afterRight : width * 0.5 + 50,
              child: Image.asset(
                "assets/icons/logo/logo1.png",
                height: iconHeight,
                width: iconWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  runAnimate() {
    Future.delayed(Duration(seconds: 2),
            (){
          setState(() {
            animate = true;
          });
        }
    );
  }
}
