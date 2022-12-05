import 'package:flutter/material.dart';

class BottonAnimationLogic {
  late AnimationController _animationcontroller;
  late Animation<double> _animationscale;

  get animationScale => _animationscale;

  BottonAnimationLogic(TickerProvider tickerProvider) {
    _animationcontroller = AnimationController(
        vsync: tickerProvider, duration: Duration(microseconds: 500));
    _animationscale = _animationcontroller
        .drive(CurveTween(curve: Interval(0.1, 0.7)))
        .drive(Tween(begin: 1.0, end: 1.3));
  }
  void dispose() {
    _animationcontroller.dispose();
  }

  void start() {
    _animationcontroller
        .forward()
        .whenComplete(() => _animationcontroller.reset());
  }
}
