import 'package:bakht/presentation/pages/home/controllers/tabs_controller.dart';
import 'package:flutter/material.dart';

class AnimatedHomeIcon extends StatefulWidget {
  final Color startColor;
  final Color endColor;
  final Color fixedColor;
  final Size size;
  final int index;
  final TabsController tabsController;
  const AnimatedHomeIcon({
    Key? key,
    required this.startColor,
    required this.endColor,
    required this.size,
    required this.index,
    required this.tabsController,
    required this.fixedColor
  }) : super(key: key);

  @override
  _AnimatedHomeIconState createState() => _AnimatedHomeIconState();
}

class _AnimatedHomeIconState extends State<AnimatedHomeIcon>
    with TickerProviderStateMixin {
  late final AnimationController controller;

  late final Animation<double> smallDistanceAnimation;

  late final Animation<Color?> colorAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    colorAnimation = ColorTween(
            begin: widget.startColor,
            end: widget.endColor,
    )
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    smallDistanceAnimation = Tween<double>(begin: 0, end: widget.size.width / 8).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    controller.forward().then((value) =>{
      if(widget.tabsController.tabIndex != widget.index)
        controller.reverse()
    }

    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
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
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            size: widget.size,
            painter: HomeIconPaint(
                color: colorAnimation.value ?? Colors.transparent,
                smallDistance: smallDistanceAnimation.value,
              borderColor: widget.fixedColor
            ),
          );
        },
      ),
    );
  }
}

class HomeIconPaint extends CustomPainter {
  final Color color;
  final Color borderColor;
  final double smallDistance;

  HomeIconPaint({required this.color, required this.smallDistance, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    double middleX = size.width / 2;
    double middleY = size.height / 2;
    double startX = 0;
    double startY = 0;
    double endX = size.width;
    double endY = size.height;

    var paint3 = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var paint4 = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    final path1 = Path()
      ..moveTo(middleX, startY)
      ..lineTo(startX, middleY)
      ..lineTo(startX + smallDistance, middleY)
      ..lineTo(startX + smallDistance, endY)
      ..lineTo(middleX, endY);
    final path2 = Path()
      ..moveTo(middleX, startY)
      ..lineTo(endX, middleY)
      ..lineTo(endX - smallDistance, middleY)
      ..lineTo(endX - smallDistance, endY)
      ..lineTo(middleX, endY);
    final path3 = Path()
      ..moveTo(middleX - smallDistance, middleY + smallDistance)
      ..lineTo(middleX + smallDistance, middleY + smallDistance)
      ..lineTo(middleX + smallDistance, endY )
      ..lineTo(middleX - smallDistance, endY )
      ..lineTo(middleX - smallDistance, middleY + smallDistance);

    canvas.drawPath(path1, paint3);
    canvas.drawPath(path2, paint3);
    canvas.drawPath(path3, paint4);

  }

  @override
  bool shouldRepaint(covariant HomeIconPaint oldDelegate) {
    return oldDelegate.smallDistance != smallDistance;
  }
}
