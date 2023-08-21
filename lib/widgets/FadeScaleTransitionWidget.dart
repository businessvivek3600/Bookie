import 'package:flutter/material.dart';
import 'package:my_global_tools/utils/widget_animation_utils.dart';

class MyCustomAnimatedWidget extends StatefulWidget {
  const MyCustomAnimatedWidget(
      {super.key,
      required this.child,
      this.onClick,
      this.fadeEnable = true,
      this.offsetEnable = true,
      this.animationDuration = 1000,
      this.curve = Curves.fastOutSlowIn,
      this.animationsType = MyWidgetAnimationsType.none});

  final void Function(GlobalKey<State<StatefulWidget>> p1)? onClick;
  final Widget child;
  final bool fadeEnable;
  final bool offsetEnable;
  final int animationDuration;
  final Curve curve;
  final MyWidgetAnimationsType animationsType;
  @override
  State<MyCustomAnimatedWidget> createState() => _MyCustomAnimatedWidgetState();
}

class _MyCustomAnimatedWidgetState extends State<MyCustomAnimatedWidget>
    with TickerProviderStateMixin {
  bool searchMode = false;

  late AnimationController _animationController;
  late Animation<double> offsetAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));
    offsetAnimation =
        Tween<double>(begin: widget.offsetEnable ? 200 : 0, end: 0).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.fastOutSlowIn));
    fadeAnimation = Tween<double>(begin: widget.fadeEnable ? 0.2 : 1, end: 1)
        .animate(
            CurvedAnimation(parent: _animationController, curve: widget.curve));
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget getChild(Animation<double> animation) {
    switch (widget.animationsType) {
      case MyWidgetAnimationsType.none:
        return widget.child;
      case MyWidgetAnimationsType.grow:
        return MyWidgetAnimations.grow(animation, widget.child);
      case MyWidgetAnimationsType.shrink:
        return MyWidgetAnimations.shrink(animation, widget.child);
      case MyWidgetAnimationsType.fromLeft:
        return MyWidgetAnimations.fromLeft(animation, widget.child);
      case MyWidgetAnimationsType.fromRight:
        return MyWidgetAnimations.fromRight(animation, widget.child);
      case MyWidgetAnimationsType.fromTop:
        return MyWidgetAnimations.fromTop(animation, widget.child);
      case MyWidgetAnimationsType.fromBottom:
        return MyWidgetAnimations.fromBottom(animation, widget.child);
      default:
        return widget.child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: offsetAnimation,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0, offsetAnimation.value),
            child: FadeTransition(
                opacity: fadeAnimation, child: getChild(fadeAnimation)),
          );
        });
  }
}

enum TransitionType {
  bottom,
  top,
  right,
  left,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class FadeScaleTransitionWidget extends StatefulWidget {
  final TransitionType transitionType;
  final Widget child;
  final Curve curve;
  final int duration;

  const FadeScaleTransitionWidget(
      {super.key,
      this.transitionType = TransitionType.topLeft,
      this.curve = Curves.easeInOut,
      required this.child,
      this.duration = 500});

  @override
  _FadeScaleTransitionWidgetState createState() =>
      _FadeScaleTransitionWidgetState();
}

class _FadeScaleTransitionWidgetState extends State<FadeScaleTransitionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);

    switch (widget.transitionType) {
      case TransitionType.bottom:
        _slideAnimation =
            Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(_animationController);
        break;
      case TransitionType.top:
        _slideAnimation =
            Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                .animate(_animationController);
        break;
      case TransitionType.right:
        _slideAnimation =
            Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(_animationController);
        break;
      case TransitionType.left:
        _slideAnimation =
            Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                .animate(_animationController);
        break;
      case TransitionType.topLeft:
        _slideAnimation =
            Tween<Offset>(begin: const Offset(-1, -1), end: Offset.zero)
                .animate(_animationController);
        break;
      case TransitionType.topRight:
        _slideAnimation =
            Tween<Offset>(begin: const Offset(1, -1), end: Offset.zero)
                .animate(_animationController);
        break;
      case TransitionType.bottomLeft:
        _slideAnimation =
            Tween<Offset>(begin: const Offset(-1, 1), end: Offset.zero)
                .animate(_animationController);
        break;
      case TransitionType.bottomRight:
        _slideAnimation =
            Tween<Offset>(begin: const Offset(1, 1), end: Offset.zero)
                .animate(_animationController);
        break;
    }

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: widget.curve));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(scale: _scaleAnimation, child: widget.child));
  }
}
