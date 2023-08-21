import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'text.dart';

class MyDialogs {
  //todo: use awesome_dialog

  // quick alert
  static showQuickSuccessDialog(BuildContext context,
      {String? desc, String? title}) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: title,
        text: desc);
  }

  static showQuickErrorsDialog(BuildContext context,
      {String? desc, String? title}) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: title ?? 'Oops...',
        text: desc ?? 'Sorry, something went wrong');
  }

  static showQuickWarningDialog(BuildContext context,
      {String? desc, String? title}) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: title ?? 'Oops...',
        text: desc ?? 'Sorry, something went wrong');
  }

  static showQuickInfoDialog(BuildContext context,
      {String? desc, String? title}) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: title ?? 'Oops...',
        text: desc ?? 'Sorry, something went wrong');
  }

  static showQuickConfirmDialog(BuildContext context,
      {String? desc,
      String? title,
      Function? onConfirm,
      Function? onCancel}) async {
    await QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: title,
        text: desc,
        confirmBtnText: 'Confirm',
        cancelBtnText: 'Cancel',
        confirmBtnColor: Colors.white,
        // backgroundColor: Colors.black,
        confirmBtnTextStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        // barrierColor: Colors.white,
        // titleColor: Colors.white,
        // textColor: Colors.white,
        onCancelBtnTap: onCancel != null ? () => onCancel() : null,
        onConfirmBtnTap: onConfirm != null ? () => onConfirm() : null);
  }

  static showQuickLoadingDialog(BuildContext context,
      {String? desc, String? title}) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: title ?? 'Loading...',
      text: desc ?? 'Fetching your data',
    );
  }

  static showQuickCustomDialog(BuildContext context,
      {String? desc, String? title}) {
    var message = '';
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      barrierDismissible: true,
      confirmBtnText: 'Save',
      title: title ?? 'My Dialog',
      text: desc,
      // customAsset: 'assets/custom.gif',
      widget: TextFormField(
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Enter Phone Number',
          prefixIcon: Icon(Icons.phone_outlined),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        onChanged: (value) => message = value,
      ),
      onConfirmBtnTap: () async {
        if (message.length < 5) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Please input something',
          );
          return;
        }
        Navigator.pop(context);
        await showQuickLoadingDialog(context);
        await Future.delayed(const Duration(milliseconds: 3000));
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 3000));
        await QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: "Phone number '$message' has been saved!.");
      },
    );
  }

  // Panara Confirm Dialog
  static showPanaraInfoDialog(BuildContext context,
      {String? desc,
      String? title,
      bool dismissible = false,
      VoidCallback? onCancel,
      VoidCallback? onConfirm}) {
    PanaraConfirmDialog.showAnimatedGrow(
      context,
      title: title ?? "Hello",
      message: desc ?? "This is the Panara Confirm Dialog Normal.",
      confirmButtonText: "Confirm",
      cancelButtonText: "Cancel",
      onTapCancel: () {
        Navigator.pop(context);
      },
      onTapConfirm: () {
        Navigator.pop(context);
        if (onConfirm != null) onConfirm();
      },
      barrierDismissible: dismissible,
      panaraDialogType: PanaraDialogType.normal,
    );
  }

  static showPanaraConfirmDialog(
    BuildContext context, {
    String? desc,
    String? confirmButtonText,
    String? title,
    String? image,
    String? cancelButtonText,
    bool dismissible = false,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool noImage = true,
  }) {
    PanaraConfirmDialog.showAnimatedGrow(
      context,
      title: title,
      noImage: noImage || image == null,
      imagePath: image,
      message: desc ?? "This is the Panara Confirm Dialog Normal.",
      confirmButtonText: confirmButtonText ?? "Confirm",
      cancelButtonText: cancelButtonText ?? "Cancel",
      onTapCancel: () {
        if (onCancel != null) onCancel();
        Navigator.pop(context);
      },
      onTapConfirm: () {
        if (onConfirm != null) onConfirm();
        Navigator.pop(context);
      },
      barrierDismissible: dismissible,
      panaraDialogType: PanaraDialogType.custom,
    );
  }

  static showPanaraSuccessDialog(BuildContext context,
      {String? desc,
      String? title,
      bool dismissible = false,
      VoidCallback? onCancel,
      VoidCallback? onConfirm}) {
    PanaraConfirmDialog.showAnimatedGrow(
      context,
      title: title,
      message: desc ?? "This is the Panara Confirm Dialog Normal.",
      confirmButtonText: "Confirm",
      cancelButtonText: "Cancel",
      onTapCancel: () {
        if (onCancel != null) onCancel();
        Navigator.pop(context);
      },
      onTapConfirm: () {
        if (onConfirm != null) onConfirm();
        Navigator.pop(context);
      },
      barrierDismissible: dismissible,
      panaraDialogType: PanaraDialogType.success,
    );
  }

  // custom dialogs
  static Future<T?> showCustomDialogs<T extends Object?>(
    BuildContext context, {
    String? desc,
    String? confirmButtonText,
    String? title,
    String? image,
    String? cancelButtonText,
    bool dismissible = false,
    bool hideCancel = false,
    bool hideConfirm = false,
    bool autoDismiss = false,
    int duration = 1000,
    TextAlign titleAlign = TextAlign.start,
    TextAlign descAlign = TextAlign.start,
    Color? backgroundColor,
    Color? cancelBtnColor,
    Color? confirmBTnColor,
    MainAxisAlignment actionsAlignment = MainAxisAlignment.spaceEvenly,
    T? Function()? onCancel,
    T? Function()? onConfirm,
    bool noImage = true,
  }) async {
    /* return  showDialog(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (BuildContext context) {
          var title = titleLargeText('Switch to MLM', context,
              textAlign: TextAlign.center);
          var content =
          bodyMedText('Are you sure you want to explore MLM?', context);
          var action = [
            TextButton(
                child: bodyMedText('Cancel', context,
                    color: Theme.of(context).colorScheme.error),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: bodyMedText('Confirm', context,
                  color: Theme.of(context).colorScheme.primary),
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
            ),
          ];
          return Platform.isIOS
              ? CupertinoAlertDialog(
              title: title, content: content, actions: action)
              : AlertDialog(title: title, content: content, actions: action);
        },*/
    return await showDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierLabel: '',
      // transitionDuration: const Duration(milliseconds: 300),
      // transitionBuilder: (context, animation, secondaryAnimation, child) =>
      //     MyWidgetAnimations.grow(animation, secondaryAnimation, child),
      builder: (context) {
        if (autoDismiss) {
          Future.delayed(Duration(milliseconds: duration), () => Get.back());
        }
        var titleText = title != null
            ? titleLargeText(title, context,
                textAlign: titleAlign, fontSize: 18)
            : null;
        var descText = desc != null
            ? bodyMedText(desc, context, textAlign: descAlign)
            : null;
        var actions = [
          if (!hideCancel)
            FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: cancelBtnColor ?? Colors.grey[400]),
                child: bodyMedText(cancelButtonText ?? 'Cancel', context,
                    color: Colors.white),
                onPressed: () {
                  if (onCancel != null) {
                    onCancel();
                  }
                  Future.delayed(
                      const Duration(milliseconds: 500), () => Get.back());
                }),
          if (!hideConfirm)
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: confirmBTnColor),
              child: bodyMedText(confirmButtonText ?? 'Confirm', context,
                  color: Colors.white),
              onPressed: () async {
                if (onConfirm != null) {
                  onConfirm();
                }
                Future.delayed(
                    const Duration(milliseconds: 500), () => Get.back());
              },
            ),
        ];
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: titleText, content: descText, actions: actions)
            : AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: titleText,
                backgroundColor: Colors.white,
                content: descText,
                actionsAlignment: actionsAlignment,
                actions: actions);
      },
    );
  }

  static showCircleLoader(
      {bool barrierDismissible = false,
      Color? bgColor,
      double scaleFactor = 1,
      String? lottieFile}) async {
    await showDialog<void>(
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return WillPopScope(
          onWillPop: () async => barrierDismissible,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: lottieFile != null ? null : const EdgeInsetsDirectional.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color:
                      bgColor ?? Theme.of(Get.context!).colorScheme.onPrimary,
                ),
                constraints: BoxConstraints(
                    minWidth: double.minPositive,
                    minHeight: double.minPositive,
                    maxHeight: Get.width * 0.2 * scaleFactor,
                    maxWidth: Get.width * 0.2 * scaleFactor),
                child: Center(
                  child: lottieFile != null
                      ? assetLottie(lottieFile, fit: BoxFit.cover)
                      : const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
