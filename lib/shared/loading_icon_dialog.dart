import 'package:flutter/material.dart';

class IconRotationTransition extends StatefulWidget {
  final AnimationController controller;

  const IconRotationTransition({super.key, required this.controller});

  @override
  State<IconRotationTransition> createState() => _IconRotationTransitionState();
}

class _IconRotationTransitionState extends State<IconRotationTransition>
    with TickerProviderStateMixin {
  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: widget.controller,
    curve: Curves.elasticOut,
  );

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Icon(Icons.hourglass_empty_outlined, size: 40),
    );
  }
}
