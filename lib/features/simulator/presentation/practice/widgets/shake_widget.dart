import 'dart:math';

import 'package:flutter/material.dart';

/// Animated shake container triggered upon wrong answer in Practice Mode.
class ShakeWidget extends StatefulWidget {
  const ShakeWidget({super.key, required this.child, required this.controller});

  final Widget child;
  final ShakeController controller;

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class ShakeController {
  _ShakeWidgetState? _state;

  void shake() {
    _state?.shake();
  }
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    widget.controller._state = this;
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void didUpdateWidget(ShakeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller._state = this;
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void shake() {
    _animController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        // Sine wave offset for horizontal shake
        final offset =
            sin(_animController.value * pi * 4) *
            8 *
            (1 - _animController.value);
        return Transform.translate(offset: Offset(offset, 0), child: child);
      },
      child: widget.child,
    );
  }
}
