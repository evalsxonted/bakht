import 'package:bakht/presentation/pages/home/controllers/tabs_controller.dart';
import 'package:flutter/material.dart';

class AnimatedGamesIcon extends StatefulWidget {
  final Color startColor;
  final Color endColor;
  final Color fixedColor;
  final Size size;
  final int index;
  final TabsController tabsController;

  const AnimatedGamesIcon({
    Key? key,
    required this.startColor,
    required this.endColor,
    required this.size,
    required this.fixedColor,
    required this.index,
    required this.tabsController,
  }) : super(key: key);

  @override
  _AnimatedGamesIconState createState() => _AnimatedGamesIconState();
}

class _AnimatedGamesIconState extends State<AnimatedGamesIcon>
    with TickerProviderStateMixin {
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late final Animation<Color?> colorAnimation;
  late AnimationController controller2;

  @override
  void initState() {
    super.initState();
    controller2 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation1 = Tween<double>(
      begin: 0,
      end: -0.07,
    ).animate(
      CurvedAnimation(parent: controller2, curve: Curves.linear),
    );
    animation2 = Tween<double>(
      begin: 0,
      end: -0.05,
    ).animate(
      CurvedAnimation(parent: controller2, curve: Curves.linear),
    );
    animation3 = Tween<double>(
      begin: 0,
      end: -0.03,
    ).animate(
      CurvedAnimation(parent: controller2, curve: Curves.linear),
    );
    colorAnimation = ColorTween(
      begin: widget.startColor,
      end: widget.endColor,
    ).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.linear,
      ),
    );
    controller2.forward().then((value) => {
          if (widget.tabsController.tabIndex != widget.index)
            controller2.reverse()
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.tabsController.tabIndex != widget.index){
      controller2.reverse();
    }
    return GestureDetector(
        onTap: () {
          controller2.reset();
          controller2.forward();
          widget.tabsController.changeTab(widget.index);
        },
        child: Container(
            alignment: Alignment.bottomCenter,
            height: widget.size.height,
            width: widget.size.width,
            child: AnimatedBuilder(
              animation: controller2,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -1,
                      child: RotationTransition(
                        alignment: Alignment.bottomLeft,
                        turns: animation3,
                        child: CustomPaint(
                          painter: CardIconPaint(
                              color: colorAnimation.value ?? Colors.transparent,
                              backgroundColor: widget.fixedColor,
                              smallDistance: 5),
                          size: widget.size,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -1,
                      child: RotationTransition(
                        alignment: Alignment.bottomLeft,
                        turns: animation2,
                        child: CustomPaint(
                          painter: CardIconPaint(
                              color: colorAnimation.value ?? Colors.transparent,
                              backgroundColor: widget.fixedColor,
                              smallDistance: 5),
                          size: widget.size,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -1,
                      child: RotationTransition(
                        alignment: Alignment.bottomLeft,
                        turns: animation1,
                        child: CustomPaint(
                          painter: CardIconPaint(
                              color: colorAnimation.value ?? Colors.transparent,
                              backgroundColor: widget.fixedColor,
                              smallDistance: 5),
                          size: widget.size,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )));
  }
}

class CardIconPaint extends CustomPainter {
  final Color color;
  final Color backgroundColor;
  final double smallDistance;

  CardIconPaint(
      {required this.color,
      required this.smallDistance,
      required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    double middleX = size.width / 2;
    double middleY = size.height / 2;
    double startX = 0;
    double startY = 0;
    double endX = size.width;
    double endY = size.height;

    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    var paint2 = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    var paint3 = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    final path1 = Path()
      ..moveTo(startX + smallDistance, startY)
      ..lineTo(endX - smallDistance, startY)
      ..lineTo(endX - smallDistance, endY)
      ..lineTo(startX + smallDistance, endY)
      ..lineTo(startX + smallDistance, startY);

    final path2 = Path()
      ..moveTo(middleX, middleY / 2)
      ..lineTo(middleX + middleX / 2 - smallDistance, middleY)
      ..lineTo(middleX, endY - middleY / 2)
      ..lineTo(middleX - middleX / 2 + smallDistance, middleY)
      ..lineTo(middleX, middleY / 2);

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path1, paint3);
  }

  @override
  bool shouldRepaint(covariant CardIconPaint oldDelegate) {
    return oldDelegate.smallDistance != smallDistance;
  }
}
