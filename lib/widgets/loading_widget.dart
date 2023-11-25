import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Center(
        child: AnimatedBuilder(
          animation: rotationController,
          builder: (_, child) {
            return Transform.rotate(
              angle: rotationController.value * 2 * math.pi,
              child: child,
            );
          },
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
