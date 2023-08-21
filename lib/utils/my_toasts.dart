import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:my_global_tools/utils/text.dart';

class Toasts {
  // awesome_snackbar_content
  static showAwesomeToast(BuildContext context,
      {required String title,
      required String content,
      ContentType? contentType,
      Color? color,
      bool? asBanner}) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: content,
        color: color,
        inMaterialBanner: asBanner ?? false,
        contentType: contentType ?? ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // show chery toast
  static showCherySuccessToast(BuildContext context, String desc,
      {String? title}) async {
    CherryToast.success(
            title: bodyMedText("Success", context, color: Colors.green),
            displayTitle: true,
            displayIcon: true,
            displayCloseButton: true,
            description: bodyMedText(desc, context, color: Colors.black),
            animationType: AnimationType.fromTop,
            borderRadius: 10,
            animationDuration: const Duration(milliseconds: 600),
            autoDismiss: true)
        .show(context);
  }

  static showErrorNormalToast(BuildContext context, String desc,
      {String? title}) async {
    CherryToast.error(
            title: bodyMedText("Error", context, color: Colors.red),
            displayTitle: true,
            displayIcon: true,
            displayCloseButton: false,
            description: bodyMedText(desc, context, color: Colors.black),
            animationType: AnimationType.fromRight,
            animationDuration: const Duration(milliseconds: 900),
            autoDismiss: true)
        .show(context);
  }

  static showWarningNormalToast(BuildContext context, String desc,
      {String? title}) async {
    CherryToast.warning(
            title: bodyMedText(title ?? "Oops!", context,
                color: Colors.red, textAlign: TextAlign.justify),
            displayTitle: true,
            displayIcon: true,
            displayCloseButton: false,
            description: bodyMedText(desc, context, color: Colors.black),
            animationType: AnimationType.fromRight,
            animationDuration: const Duration(milliseconds: 300),
            autoDismiss: true)
        .show(context);
  }

  static showNormalToast(BuildContext context, String desc,
      {String? title, bool error = false}) async {
    CherryToast(
      title: bodyMedText("", context,
          color: Colors.red, textAlign: TextAlign.justify),
      displayTitle: true,
      displayIcon: true,
      displayCloseButton: false,
      description: bodyMedText(desc, context, color: Colors.black),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(milliseconds: 900),
      autoDismiss: true,
      icon: error ? Icons.error : Icons.emoji_events_outlined,
      themeColor: error ? Colors.red : Colors.green,
    ).show(context);
  }

  ///Alert Controller
  static void successBanner() {
    Map<String, dynamic> payload = <String, dynamic>{};
    payload["data"] = "content";
    AlertController.show(
        "Success", "Success message here!", TypeAlert.success, payload);
  }

  static void warningBanner() =>
      AlertController.show("Warn!", "Warning message here!", TypeAlert.warning);

  static void errorBanner() =>
      AlertController.show("Error", "Error message here!", TypeAlert.error);
}

enum ToastType { success, failed, warning, info }

class MyToastModel {
  String message;
  ToastType type;

  MyToastModel(this.message, this.type);
}

class ToastItem extends StatelessWidget {
  const ToastItem({
    Key? key,
    this.onTap,
    required this.animation,
    required this.item,
  }) : super(key: key);

  final Animation<double> animation;
  final VoidCallback? onTap;
  final MyToastModel item;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white);

    return Padding(
      padding: const EdgeInsetsDirectional.all(8.0),
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: Container(
            decoration: BoxDecoration(
              color: _getTypeColor(item.type),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: ListTile(
              title: Text('Item ${item.message}', style: textStyle),
              trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => onTap?.call()),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return const Color(0xFF3DD89B);
      case ToastType.warning:
        return const Color(0xFFFFD873);
      case ToastType.info:
        return const Color(0xFF17A2b8);
      case ToastType.failed:
        return const Color(0xFFFF4E43);
      default:
        return const Color(0xFF3DD89B);
    }
  }
}
