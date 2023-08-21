// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:my_global_tools/providers/auth_provider.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/my_toasts.dart';
import 'package:provider/provider.dart';

import '../models/base/api_response.dart';
import '../models/base/error_response.dart';
import '../providers/connectivity_provider.dart';

class ApiHandler {
  static const String tag = 'ApiHandler';
  static void checkApi(BuildContext context, ApiResponse apiResponse,
      {bool logout = false}) {
    if (apiResponse.error is! String &&
        apiResponse.error.errors[0].message == 'Unauthorized.') {
      if (logout) {
        //todo: clear auth data and others
        Provider.of<AuthProvider>(context, listen: false).clear();
        // Provider.of<ProfileProvider>(context,listen: false).clearHomeAddress();
        // Provider.of<ProfileProvider>(context,listen: false).clearOfficeAddress();

        ///TODO: route to login screen on
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => LoginScreen()),
        //         (route) => false);
      }
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      errorLog(errorMessage, tag);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(errorMessage, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red));
    }
  }

  static void handleUncaughtError(BuildContext context, ApiResponse apiResponse,
      {bool showToast = true}) {
    String errorMessage = "";
    if (apiResponse.error is String) {
      errorMessage = apiResponse.error.toString();
    } else {
      ErrorResponse errorResponse = apiResponse.error;
      errorMessage = errorResponse.errors[0].message;
    }
    if (showToast) {
      Toasts.showErrorNormalToast(context, errorMessage);
    }
  }

  static Future<(Map<String, dynamic>?, bool)> hitApi(BuildContext context,
      String tag, String endPoint, Future<ApiResponse> Function() method,
      {bool cache = true}) async {
    bool cacheExist = await APICacheManager().isAPICacheKeyExist(endPoint);
    Map<String, dynamic>? map;
    bool status = false;

    if (isOnline) {
      ApiResponse apiResponse = await method();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        map = apiResponse.response!.data;
        try {
          status = map?["status"];
        } catch (e) {
          errorLog(e.toString(),tag);
        }
        try {
          if (status) {
            if (map != null && cache) {
              var cacheModel =
                  APICacheDBModel(key: endPoint, syncData: jsonEncode(map));
              await APICacheManager().addCacheData(cacheModel);
            }
          }
        } catch (e) {
          errorLog('$endPoint cache could not be generated  $e', tag);
        }
      } else {
        checkApi(context, apiResponse);
      }
    } else if (!isOnline && cacheExist && cache) {
      var data = (await APICacheManager().getCacheData(endPoint)).syncData;
      try {
        map = jsonDecode(data);
      } catch (e) {
        errorLog('$endPoint could not retrieve cache data', tag);
      }
    } else {
      Toasts.showWarningNormalToast(context, 'You are offline!. Try later');
    }
    return (map, cacheExist);
  }
}
