import 'package:bakht/presentation/animations/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

class LaunchFromWidgetRoute {
  final Duration transitionDuration;
  final Widget page;
  final GlobalKey widgetKey;

  LaunchFromWidgetRoute({
    required this.page,
    required this.widgetKey,
    this.transitionDuration = const Duration(milliseconds: 1000)
  });

  Route call() {
    return PageRouteBuilder(
      transitionDuration: transitionDuration,
      reverseTransitionDuration: transitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset startOffset = getCurrentOffset();
        return FadeTransition(
          opacity: animation.drive(
            Tween(begin: 0.5, end: 1),
          ),
          child: ScaleTransition(
            alignment: Alignment(
              offsetToAlignment(
                  startOffset.dx, MediaQuery.of(context).size.width),
              offsetToAlignment(
                  startOffset.dy, MediaQuery.of(context).size.height),
            ),
            scale: animation.drive(
              Tween(begin: 0, end: 1),
            ),
            child: CircularRevealAnimation(
              animation: animation,
              child: child,
            ),
          ),
        );
      },
    );
  }

  double offsetToAlignment(double num, double max) {
    return (num / max - 0.5) * 2;
  }

  Offset getCurrentOffset() {
    try {
      RenderBox renderBox =
          widgetKey.currentContext?.findRenderObject() as RenderBox;
      return renderBox.localToGlobal(Offset.zero);
    } catch (e) {
      return Offset.zero;
    }
  }
}
