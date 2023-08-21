import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_global_tools/utils/default_logger.dart';

bool isOnline = false;

class ConnectivityProvider extends ChangeNotifier {
  static const String tag = 'ConnectivityProvider';
  bool _isOnline = true;
  final Connectivity _connectivity = Connectivity();

  get getOnline => _isOnline;
  ConnectivityProvider() {
    _initialize();
  }

  void _initialize() async {
    await isConnected();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _isOnline = result != ConnectivityResult.none;
      isOnline = _isOnline;
      notifyListeners();
      if (!_isOnline) {
        _showOfflineToast();
      }
    });
  }

  Future<bool> isConnected() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    isOnline = result != ConnectivityResult.none;
    infoLog('NetworkInfo ---> isConnected $isOnline', tag);
    return result != ConnectivityResult.none;
  }

  void _showOfflineToast() {
    Fluttertoast.showToast(
        msg: "Offline", backgroundColor: Colors.red, textColor: Colors.white);
  }
}
