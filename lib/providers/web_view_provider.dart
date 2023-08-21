import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewProvider with ChangeNotifier {
   WebViewController? controller;
  final String tag = 'WebViewProvider';
}
