import 'package:flutter/material.dart';

///
/// This is the animation class containing all the animations for both dialogs.
/// you can use it separatly if you want to use them in your other widgets.
///
enum MyWidgetAnimationsType {
  fromLeft,
  fromRight,
  fromTop,
  fromBottom,
  grow,
  shrink,
  none
}

class MyWidgetAnimations {
  // slide animation from right to left
  // we need animation of type double
  static fromLeft(Animation<double> animation, Widget child,
      {Animation<double>? secondaryAnimation, bool animate = true}) {
    return SlideTransition(
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(1.0, 0.0))
          .animate(animation),
      child: child,
    );
  }

  // slide animation from left to right
  static fromRight(Animation<double> animation, Widget child,
      {Animation<double>? secondaryAnimation, bool animate = true}) {
    return SlideTransition(
      position: Tween<Offset>(
              end: Offset.zero, begin: Offset(!animate ? 1 : -1.0, 0.0))
          .animate(animation),
      child: child,
    );
  }

  // slide animation from top to bottom
  static fromTop(Animation<double> animation, Widget child,
      {Animation<double>? secondaryAnimation, bool animate = true}) {
    return SlideTransition(
      position: Tween<Offset>(
              end: Offset.zero, begin: Offset(0.0, !animate ? 1 : -1.0))
          .animate(animation),
      child: child,
    );
  }

  // slide animation from bottom to top
  static fromBottom(Animation<double> animation, Widget child,
      {Animation<double>? secondaryAnimation, bool animate = true}) {
    return SlideTransition(
      position: Tween<Offset>(
              end: Offset.zero, begin: Offset(!animate ? 1 : 0.0, 1.0))
          .animate(animation),
      child: child,
    );
  }

  // slide animation with grow effect
  static grow(Animation<double> animation, Widget child,
      {Animation<double>? secondaryAnimation, bool animate = true}) {
    return ScaleTransition(
      scale: Tween<double>(end: 1.0, begin: !animate ? 1 : 0.0).animate(
          CurvedAnimation(
              parent: animation,
              curve: const Interval(0.00, 0.50, curve: Curves.linear))),
      child: child,
    );
  }

  // slide animation with shrink effect
  static shrink(Animation<double> animation, Widget child,
      {Animation<double>? secondaryAnimation, bool animate = true}) {
    return ScaleTransition(
      scale: Tween<double>(end: 1.0, begin: animate ? 1.2 : 1).animate(
          CurvedAnimation(
              parent: animation,
              curve: Interval(animate ? 0.50 : 1, 1.00, curve: Curves.linear))),
      child: child,
    );
  }
}
