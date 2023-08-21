import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class DashboardProvider extends ChangeNotifier {
  int bottomIndex = 0;
  setBottomIndex(int val) {
    bottomIndex = val;
    notifyListeners();
  }

  final ScrollController scrollController = ScrollController();
  bool showTextField = true;
  void onScroll() {
    if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        showTextField) {
      showTextField = false;
      notifyListeners();
    }
    else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !showTextField) {
      showTextField = true;
      notifyListeners();
    }
  }
}
