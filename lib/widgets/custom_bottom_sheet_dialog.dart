import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/sized_utils.dart';

import 'FadeScaleTransitionWidget.dart';

class CustomBottomSheet extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final bool dismissible;
  final Widget child;
  final EdgeInsetsDirectional margin;
  final EdgeInsetsDirectional padding;
  final Curve curve;
  final TransitionType transitionType;
  final bool showCloseIcon;
  final Future<bool> Function() onDismiss;

  final int duration;

  const CustomBottomSheet(
      {Key? key,
      this.height,
      this.width,
      this.backgroundColor,
      this.dismissible = true,
      required this.child,
      this.padding =
          const EdgeInsetsDirectional.only(start: 20, bottom: 20, end: 20, top: 30),
      this.margin = const EdgeInsetsDirectional.only(start: 20, bottom: 60, end: 20),
      this.curve = Curves.easeIn,
      required this.onDismiss,
      this.transitionType = TransitionType.bottom,
      this.duration = 500,
      required this.showCloseIcon})
      : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();

  static Future<T?> show<T>(
      {required BuildContext context,
      double? height,
      double? width,
      Color? backgroundColor,
      bool dismissible = true,
      bool enableDrag = false,
      Future<bool> Function()? onDismiss,
      required WidgetBuilder builder,
      Curve curve = Curves.bounceInOut,
      transitionType = TransitionType.bottom,
      int duration = 500,
      double elevation = 0,
      bool showCloseIcon = true}) async {
    return await showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: elevation,
      isScrollControlled: true,
      enableDrag: enableDrag,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          height: height,
          width: width,
          transitionType: transitionType,
          backgroundColor: backgroundColor,
          dismissible: dismissible,
          showCloseIcon: showCloseIcon,
          curve: curve,
          onDismiss: onDismiss != null && !dismissible
              ? () async {
                  bool willPop = await onDismiss();
                  infoLog('**** will pop $willPop', 'CustomBottomSheet.show');
                  if (willPop) {
                    context.pop();
                  }
                  return willPop;
                }
              : () async => false,
          duration: duration,
          child: builder(context),
        );
      },
    );
  }
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.dismissible
          ? () async => true
          : () async {
              bool willPop = await widget.onDismiss();
              infoLog('**** will pop $willPop', '_CustomBottomSheetState');
              return willPop;
            },
      child: FadeScaleTransitionWidget(
        curve: widget.curve,
        transitionType: widget.transitionType,
        duration: widget.duration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  padding: widget.padding,
                  margin: widget.margin,
                  height: widget.height,
                  width: widget.width ?? MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          widget.backgroundColor ?? Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: widget.child,
                ),
                if (widget.showCloseIcon)
                  Positioned(
                      right: widget.margin.end + 10,
                      top: widget.margin.top + 10,
                      child: GestureDetector(
                          onTap: widget.dismissible
                              ? () => context.pop()
                              : widget.onDismiss,
                          child: const Icon(Icons.clear)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
