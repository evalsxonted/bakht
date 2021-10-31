import 'package:flutter/material.dart';

class BouncingIcon extends StatefulWidget {
  final double size;
  final IconData icon;
  final Color color;
  final VoidCallback voidCallback;
  const BouncingIcon(
      {Key? key,
      required this.voidCallback,
      required this.size,
      required this.icon,
      required this.color})
      : super(key: key);

  @override
  State<BouncingIcon> createState() => _BouncingIconState();
}

class _BouncingIconState extends State<BouncingIcon>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late double scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
        lowerBound: 0.6,
        upperBound: 1);
    scale = controller.value;
    animation = new CurvedAnimation(parent: controller, curve: Curves.bounceOut)
      ..addListener(() {
        setState(() {
          scale = controller.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          controller.reset();
          controller.forward();
          widget.voidCallback();
        },
        child: ScaleTransition(
          scale: animation,
          child: Icon(
            widget.icon,
            color: widget.color,
            size: widget.size,
          ),
        ));
  }
}
