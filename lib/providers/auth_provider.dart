import 'package:flutter/material.dart';
import 'package:my_global_tools/constants/api_const.dart';
import 'package:my_global_tools/utils/api_handler_utils.dart';
import 'package:my_global_tools/utils/default_logger.dart';

import '../functions/repositories/auth_repo.dart';
import '../widgets/MultiStageButton.dart';
import 'connectivity_provider.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  final String tag = 'AuthProvider';
  AuthProvider({required this.authRepo});

  bool loadingStates = false;
  Future<void> getStates(BuildContext context) async {
    loadingStates = true;
    notifyListeners();
    var (map, cacheStatus) = await ApiHandler.hitApi(
        context, tag, ApiConst.register, () => authRepo.register({}));
    try {
      if (map != null) {}
    } catch (e) {
      errorLog('error on getStates', tag);
    }
    loadingStates = false;
    notifyListeners();
  }

  Future<bool> clearSharedData() async => await authRepo.clearSharedData();

  ButtonLoadingState loginStatus = ButtonLoadingState.idle;
  String? errorText;
  Future<void> login({required bool status}) async {
    Map map = {};
    try {
      if (isOnline) {
        loginStatus = ButtonLoadingState.loading;
        errorText = '';
        notifyListeners();
        await Future.delayed(const Duration(seconds: 3));
        if (status) {
          try {
            loginStatus = ButtonLoadingState.completed;
            errorText = 'success message';
            notifyListeners();
          } catch (e) {}
        } else {
          loginStatus = ButtonLoadingState.failed;
          errorText = 'error message';
          notifyListeners();
        }
      } else {
        loginStatus = ButtonLoadingState.failed;
        errorText = 'failed message';
        notifyListeners();
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 3));
      loginStatus = ButtonLoadingState.failed;
      errorText = 'Some thing went wrong!';
      notifyListeners();
    }
    await Future.delayed(const Duration(seconds: 3));
    loginStatus = ButtonLoadingState.idle;
    errorText = null;
    notifyListeners();
  }

  clear() async {
    await clearSharedData();
  }
}
