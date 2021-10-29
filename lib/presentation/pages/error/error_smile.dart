import 'package:flutter/material.dart';

class ErrorSmile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xff292e55),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 50, end: -50),
        duration: Duration(seconds: 3),
        builder: (context, double value, child) {
          return Stack(
            children: [
              CustomPaint(
                size: Size(200, 200),
                painter: SmilePainter(value),
              ),
              CustomPaint(
                size: Size(200, 200),
                painter: EyesPaint(),
              ),
            ],
          );
        },
      ),
    );
  }
}


class SmilePainter extends CustomPainter {
  final double yAxis;

  SmilePainter(this.yAxis);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff36a1d4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    final curvePath = Path()
      ..moveTo(50, 130)
      ..relativeQuadraticBezierTo(50, yAxis, 100, 0);

    canvas.drawPath(curvePath, paint1);
  }

  @override
  bool shouldRepaint(covariant SmilePainter oldDelegate) {
    return oldDelegate.yAxis != this.yAxis;
  }
}

class EyesPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff36a1d4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(Offset(65, 60), 10, paint1);
    canvas.drawCircle(Offset(130, 60), 10, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
