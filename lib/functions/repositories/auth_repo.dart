import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_global_tools/constants/api_const.dart';
import 'package:my_global_tools/constants/sp_constants.dart';
import 'package:my_global_tools/models/user/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/base/api_response.dart';
import '../dio/dio_client.dart';
import '../dio/exception/api_error_handler.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.dioClient, required this.sharedPreferences});

  ///:register
  Future<ApiResponse> register(Map<String, UserData?> data) async {
    try {
      Response response = await dioClient.post(ApiConst.register, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for  user token
  Future<void> saveUser(UserData userData) async {
    try {
      await sharedPreferences.setString(
          SPConst.user, jsonEncode({'status': '1'}));
    } catch (e) {
      rethrow;
    }
  }

  Future<UserData?> getUser() async {
    UserData? userData;
    try {
      var data = sharedPreferences.getString(SPConst.user);
      if (data != null) {
        // userData = jsonDecode(data);
        userData = UserData(status: '1');
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<String> getUserID() async {
    // UserData? _userData;
    String id = '';
    // try {
    //   var data = await sharedPreferences.getString(SPConstants.user);
    //   if (data != null) {
    //     _userData = UserData.fromJson(jsonDecode(data));
    //     id = _userData.id ?? '';
    //   }
    // } catch (e) {
    //   throw e;
    // }
    return id;
  }

  Future<bool> clearSharedData() async {
    //sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(SPConst.userToken);
    sharedPreferences.remove(SPConst.user);
    // FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    return true;
  }
}
