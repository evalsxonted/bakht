import 'package:bakht/presentation/pages/home/controllers/tabs_controller.dart';
import 'package:flutter/material.dart';

class AnimatedCartIcon extends StatefulWidget {
  final Color startColor;
  final Color endColor;
  final Color fixedColor;
  final Size size;
  final int index;
  final TabsController tabsController;
  const AnimatedCartIcon(
      {Key? key,
        required this.startColor,
        required this.endColor,
        required this.size,
        required this.fixedColor,
        required this.index,
        required this.tabsController
      })
      : super(key: key);

  @override
  _AnimatedCartIconState createState() => _AnimatedCartIconState();
}

class _AnimatedCartIconState extends State<AnimatedCartIcon>
    with TickerProviderStateMixin {
  late Animation<double> animationTopX;
  late Animation<double> animationTopY;
  late Animation<double> animationBottomY;
  late Animation<double> animationMiddleY;
  late final Animation<Color?> colorAnimation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animationTopX = Tween<double>(
      begin: 100,
      end: 0,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );
    animationTopY = Tween<double>(
      begin: 90,
      end: 45,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );
    animationBottomY = Tween<double>(
      begin: 400,
      end: 490,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );
    animationMiddleY = Tween<double>(
      begin: 306,
      end: 400,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );
    colorAnimation = ColorTween(
      begin: widget.startColor,
      end: widget.endColor,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    controller.forward().then((value) => {
      if (widget.tabsController.tabIndex != widget.index)
        controller.reverse()
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.tabsController.tabIndex != widget.index){
      controller.reverse();
    }
    return GestureDetector(
        onTap: () {
          controller.reset();
          controller.forward();
          widget.tabsController.changeTab(widget.index);
        },
        child: Container(
            height: widget.size.height ,
            width: widget.size.width ,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: CartIconPaint(
                      primaryColor:
                      colorAnimation.value ?? Colors.transparent,
                      bottomY: animationBottomY.value,
                      topX: animationTopX.value,
                      topY: animationTopY.value,
                      middleY: animationMiddleY.value
                  ),
                  size: widget.size,
                );
              },
            )));
  }
}

class CartIconPaint extends CustomPainter {
  final Color primaryColor;
  final double topX;
  final double topY;
  final double bottomY;
  final double middleY;

  CartIconPaint({
    required this.primaryColor,
    required this.topX,
    required this.topY,
    required this.bottomY,
    required this.middleY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50
      ..strokeCap = StrokeCap.round;
    var paint2 = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path1 = Path()
      ..moveTo(topX, topY)
      ..lineTo(85, 45)
      ..lineTo(100, 90);

    final path2 = Path()
      ..moveTo(85, 45)
      ..lineTo(165, 306)
      ..lineTo(445, 306)
      ..lineTo(490, 105)
      ..lineTo(105, 105);

    final path3 = Path()
      ..moveTo(165, 306)
      ..lineTo(145, middleY)  //line from y 306
      ..lineTo(445, middleY);  //line from y 306

    final path4 = Path()
      ..moveTo(100, 90)
      ..lineTo(165, 306)
      ..lineTo(445, 306);

    canvas.scale(size.width / 512, size.height / 512);
    canvas.drawPath(path4, paint2);
    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint1);
    canvas.drawPath(path3, paint1);
    // y from 306
    canvas.drawCircle(Offset(225, bottomY), 50, paint2);
    canvas.drawCircle(Offset(375, bottomY), 50, paint2);
  }

  @override
  bool shouldRepaint(covariant CartIconPaint oldDelegate) {
    return oldDelegate.primaryColor != primaryColor;
  }
}
