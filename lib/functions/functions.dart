import 'dart:async';
import 'dart:io';

import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_global_tools/constants/app_const.dart';
import 'package:my_global_tools/constants/app_const.dart';
import 'package:my_global_tools/constants/sp_constants.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:html/parser.dart';
import 'package:my_global_tools/utils/my_advanved_toasts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

AppLocalizations get getLang => AppLocalizations.of(Get.context!);

exitTheApp() async {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  } else {
    errorLog('App exit failed!', 'Functions');
  }
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString =
      parse(document.body?.text).documentElement?.text ?? '';

  return parsedString;
}

//launch app stores
void launchPlayStore() async {
  const playStoreUrl =
      "https://play.google.com/store/apps/details?id=${AppConst.appPlayStoreId}";

  if (await canLaunch(playStoreUrl)) {
    await launch(playStoreUrl);
  } else {
    throw 'Could not launch Play Store';
  }
}

void launchAppStore() async {
  const appStoreUrl =
      "https://itunes.apple.com/app/your-app-name/id${AppConst.appAppleStoreId}?mt=8";

  if (await canLaunch(appStoreUrl)) {
    await launch(appStoreUrl);
  } else {
    throw 'Could not launch App Store';
  }
}

///Functions: Setup app rating dynamically
Future<bool> setupAppRating(int hours) async {
  bool showRating = false;
  var dt = DateTime.now();
  var prefs = await SharedPreferences.getInstance();
  String? scheduledDate = prefs.getString(SPConst.appRatingScheduleDate);
  if (scheduledDate == null) {
    showRating = false;
    await prefs.setString(SPConst.appRatingScheduleDate,
        dt.add(Duration(hours: hours)).toIso8601String());
    logD(
        'user was not scheduled to rate  $scheduledDate show rating $showRating');
  } else if (DateTime.parse(scheduledDate).isBefore(dt)) {
    showRating = true;
    await prefs.setString(SPConst.appRatingScheduleDate,
        dt.add(Duration(hours: hours)).toIso8601String());
    logD(
        'user is now mature to rate the app $scheduledDate show rating $showRating');
  } else {
    showRating = false;
    logD(
        'user is not mature to rate the app $scheduledDate show rating $showRating');
  }
  return showRating;
}

/// check for global activation on base of app-config
/*
void checkServiceEnableORDisable(String serviceKey, VoidCallback callback) {
  CompanyInfoModel? company = sl.get<AuthProvider>().companyInfo;
  bool perForm = false;
  String? alert;
  String? key;
  if (company != null) {
    switch (serviceKey) {
      case 'mobile_is_subscription':
        perForm = company.mobileIsSubscription != null &&
            company.mobileIsSubscription == "1";
        alert = "Subscription is temporary disabled.";

        key = serviceKey;
        break;
      case 'mobile_is_cash_wallet':
        perForm = company.mobileIsCashWallet != null &&
            company.mobileIsCashWallet == "1";
        alert = "Cash wallet is temporary disabled.";
        key = serviceKey;
        break;
      case 'mobile_is_commission_wallet':
        perForm = company.mobileIsCommissionWallet != null &&
            company.mobileIsCommissionWallet == "1";
        alert = "Commission wallet is temporary disabled.";
        key = serviceKey;
        break;
      case 'mobile_is_voucher':
        perForm =
            company.mobileIsVoucher != null && company.mobileIsVoucher == "1";
        alert = "Vouchers are temporary disabled.";
        key = serviceKey;
        break;
      case 'mobile_is_event':
        perForm = company.mobileIsEvent != null && company.mobileIsEvent == "1";
        alert = "Events are temporary disabled.";
        key = serviceKey;
        break;
      case 'mobile_chat_disabled':
        perForm = company.mobileChatDisabled != null &&
            company.mobileChatDisabled != "0";
        alert = "New Chat is temporary disabled.";
        key = serviceKey;
        break;
      default:
        perForm = true;
        key = serviceKey;
        break;
    }
  }
  logD('checkServiceEnableORDisable $key ${company?.mobileIsSubscription}');
  if (!perForm) {
    Fluttertoast.showToast(msg: alert ?? '');
    return;
  }
  callback();
}
*/

Future<void> shareApp() async {
  await Share.share('check out my website https://example.com',
      subject: 'Look what I made!');
}

/// Copy To Clipboard And ShowToast Message
void copyToClipboardAndShowToast(String text, BuildContext context) {
  Clipboard.setData(ClipboardData(text: text));
  AdvanceToasts.showNormalElegant(context, 'Link copied successfully!',
      notificationType: NotificationType.success);
}

Future<dynamic> future(int ms,
    [FutureOr<dynamic> Function()? computation]) async {
  return await Future.delayed(Duration(milliseconds: ms));
}

double inKB(int size) => size / ~1024;
double inMB(int size) => (size / ~1024) / ~1024;


void openGoogleMapsDirections(double lat,double long) async {
  final url =
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$long';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}