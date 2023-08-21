import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_global_tools/screens/Onboardings/on_boarding_page.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/my_dialogs.dart';
import 'package:my_global_tools/utils/sp_utils.dart';

import '../functions/repositories/auth_repo.dart';
import '../models/user/user_data_model.dart';
import '../providers/dashboard_provider.dart';
import '../repo_injection.dart';

/// A scope that provides [StreamAuth] for the subtree.
class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  /// Creates a [StreamAuthScope] sign in scope.
  StreamAuthScope({super.key, required super.child})
      : super(notifier: StreamAuthNotifier());

  /// Gets the [StreamAuth].
  static StreamAuth of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StreamAuthScope>()!
        .notifier!
        .streamAuth;
  }
}

/// A class that converts [StreamAuth] into a [ChangeNotifier].
class StreamAuthNotifier extends ChangeNotifier {
  /// Creates a [StreamAuthNotifier].
  StreamAuthNotifier() : streamAuth = StreamAuth() {
    streamAuth.onCurrentUserChanged.listen((UserData? user) {
      notifyListeners();
    });
  }

  /// The stream auth client.
  final StreamAuth streamAuth;
}

/// An asynchronous log in services mock with stream similar to google_sign_in.
///
/// This class adds an artificial delay of 3 second when logging in an user, and
/// will automatically clear the login session after [refreshInterval].
class StreamAuth {
  /// Creates an [StreamAuth] that clear the current user session in
  /// [refeshInterval] second.
  StreamAuth({this.refreshInterval = 20})
      : _userStreamController = StreamController<UserData?>.broadcast() {
    _userStreamController.stream.listen((UserData? currentUser) {
      infoLog('showOnBoarding $showOnBoarding', 'StreamAuth');
      _currentUser = currentUser;
    });
  }

  /// The current user.
  UserData? get currentUser => _currentUser;
  UserData? _currentUser;

  /// Checks whether current user is signed in with an artificial delay to mimic
  /// async operation.
  Future<bool> isSignedIn() async {
    // await Future<void>.delayed(const Duration(seconds: 1));
    var authRepo = sl.get<AuthRepo>();
    _currentUser = await authRepo.getUser();
    return _currentUser != null;
  }

  /// A stream that notifies when current user has changed.
  Stream<UserData?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<UserData?> _userStreamController;

  /// The interval that automatically signs out the user.
  final int refreshInterval;

  Timer? _timer;
  Timer _createRefreshTimer() {
    return Timer(Duration(seconds: refreshInterval), () {
      _userStreamController.add(null);
      _timer = null;
    });
  }

  /// Signs in a user with an artificial delay to mimic async operation.
  Future<void> signIn(UserData userData, {bool onBoarding = false,int bottomIndex=0}) async {
    showOnBoarding = onBoarding;
    SpUtils().setOnBoarding(false);

    var authRepo = sl.get<AuthRepo>();
    await authRepo.saveUser(userData);
    UserData? user = await authRepo.getUser();
    if (user != null) {
      //   MyDialogs.showCircleLoader();
      // }
      await Future<void>.delayed(const Duration(seconds: 3));
      // Get.back();
      _userStreamController.add(user);
      sl.get<DashboardProvider>().setBottomIndex(bottomIndex);
    }
    _timer?.cancel();
    // _timer = _createRefreshTimer();
  }

  /// Signs out the current user.
  Future<void> signOut({bool onBoarding = false}) async {
    //todo: remove this after testing on-boarding screen
    showOnBoarding = onBoarding;
    SpUtils().setOnBoarding(true);
    _timer?.cancel();
    _timer = null;
    var authRepo = sl.get<AuthRepo>();
    await authRepo.clearSharedData();
    _userStreamController.add(await authRepo.getUser());
  }
}
