import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_global_tools/utils/text.dart';

class AdvanceToasts {
  //ElegantNotification notification

  static showNormalElegant(
    BuildContext context,
    String desc, {
    String? title,
    VoidCallback? onDismiss,
    VoidCallback? onActionPressed,
    VoidCallback? onCloseButtonPressed,
    VoidCallback? onProgressFinished,
    Widget? leading,
    Widget? trailing,
    Widget? action,
    AnimationType? animationType,
    NotificationPosition? notificationPosition,
    NotificationType notificationType = NotificationType.custom,
    bool showTrailing = true,
    bool showLeading = true,
    bool autoDismiss = true,
    bool showProgressIndicator = true,
    double h = 60,
    int tDuration = 3000,
    int aDuration = 600,
    Color? color,
  }) async {
    h = action != null ? h + 15 : h;
    color = color ??
        (notificationType == NotificationType.custom
            ? Theme.of(context).textTheme.displayLarge?.color
            : notificationType == NotificationType.info
                ? CupertinoColors.link
                : notificationType == NotificationType.success
                    ? CupertinoColors.activeGreen
                    : notificationType == NotificationType.error
                        ? CupertinoColors.destructiveRed
                        : CupertinoColors.activeGreen);
    leading = leading ??
        (notificationType == NotificationType.custom
            ? Icon(Icons.slideshow, color: color)
            : notificationType == NotificationType.info
                ? Icon(CupertinoIcons.info_circle_fill, color: color)
                : notificationType == NotificationType.success
                    ? Icon(CupertinoIcons.hand_thumbsup_fill, color: color)
                    : notificationType == NotificationType.error
                        ? Icon(Icons.error_rounded, color: color)
                        : Icon(Icons.touch_app_rounded, color: color));
    ElegantNotification(
      notificationPosition: NotificationPosition.bottomCenter,
      height: h,
      animation: animationType ?? AnimationType.fromBottom,
      title: title != null ? bodyMedText(title, context) : null,
      description: capText(desc, context, color: Colors.black),
      icon: showLeading ? leading : Container(),
      progressIndicatorColor: color ?? Colors.transparent,
      showProgressIndicator: showProgressIndicator,
      autoDismiss: autoDismiss,
      action: action,
      closeButton: showTrailing
          ? (dismiss) => Container(
                margin: Directionality.of(context) == TextDirection.rtl
                    ? const EdgeInsetsDirectional.only(start: 20)
                    : const EdgeInsetsDirectional.only(end: 20),
                child: GestureDetector(
                    onTap: dismiss,
                    child: trailing ?? Icon(Icons.clear, color: color)),
              )
          : null,
      onDismiss: onDismiss,
      onActionPressed: onActionPressed,
      onCloseButtonPressed: onCloseButtonPressed,
      onProgressFinished: onProgressFinished,
      toastDuration: Duration(milliseconds: tDuration),
      animationDuration: Duration(milliseconds: aDuration),
    ).show(context);
  }
}
