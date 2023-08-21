import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_global_tools/constants/app_const.dart';
import 'package:my_global_tools/providers/web_view_provider.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/my_advanved_toasts.dart';
import 'package:my_global_tools/utils/my_dialogs.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../functions/functions.dart';
import '../repo_injection.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
  webview</a> plugin.
</p>

</body>
</html>
''';

const String kTransparentBackgroundPage = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
    p { text-align: center; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <div id="shape"></div>
    </div>
  </body>
  </html>
''';

class WebViewExample extends StatefulWidget {
  const WebViewExample(
      {super.key,
      this.url,
      this.showAppBar = '1',
      this.showToast = '1',
      this.changeOrientation = '0'});
  final String? url;
  final String showAppBar;
  final String showToast;
  final String changeOrientation;
  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  var webViewProvider = sl.get<WebViewProvider>();
  double loadingProgress = 0;
  String? currentUrl;
  late final PlatformWebViewControllerCreationParams params;

  Future<bool> willPop(WebViewProvider provider) async {
    bool willBack = false;
    var controller = provider.controller;
    if (controller == null) {
      willBack = true;
    } else {
      if (await controller.canGoBack()) {
        await controller.goBack();
      } else {
        errorLog('will back wait $willBack');
        await MyDialogs.showCustomDialogs<bool>(
          context,
          title: 'Leave ',
          desc: 'Are you sure to go back?',
          dismissible: true,
          backgroundColor: Colors.white,
          onConfirm: () {
            willBack = true;
            return null;
          },
        );
      }
    }
    errorLog('will back $willBack');
    return willBack;
  }

  @override
  void initState() {
    super.initState();
    if (widget.changeOrientation == '1') {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    initController();
  }

  initController() async {
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{});
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          setState(() {
            loadingProgress = progress.toDouble();
          });
          infoLog(
              'WebView is loading (progress : $progress%)  (loadingProgress : $loadingProgress%)');
        },
        onPageStarted: (String url) {
          infoLog('Page started loading: $url');
        },
        onPageFinished: (String url) {
          infoLog('Page finished loading: $url');
          setState(() {
            loadingProgress = 0.toDouble();
          });
        },
        onWebResourceError: (WebResourceError error) {
          infoLog('''
                      Page resource error:
                      code: ${error.errorCode}
                      description: ${error.description}
                      errorType: ${error.errorType}
                      isForMainFrame: ${error.isForMainFrame}
          ''');
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            infoLog('blocking navigation to ${request.url}');
            return NavigationDecision.prevent;
          }
          infoLog('allowing navigation to ${request.url}');
          return NavigationDecision.navigate;
        },
        onUrlChange: (UrlChange change) async {
          infoLog('url change to ${change.url}');
          currentUrl = await webViewProvider.controller!.currentUrl();
          setState(() {});
          // ignore: use_build_context_synchronously
          if (widget.showToast == '1') {
            AdvanceToasts.showNormalElegant(context,
                'Current url ${await webViewProvider.controller?.currentUrl()}',
                notificationType: NotificationType.success,
                showLeading: false,
                showProgressIndicator: false);
          }
        },
      ))
      ..addJavaScriptChannel('Toaster',
          onMessageReceived: (JavaScriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            message.message,
            style: const TextStyle(color: Colors.red),
          )),
        );
      })
      ..loadRequest(Uri.parse(widget.url ?? AppConst.siteUrl));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(false);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    webViewProvider.controller = controller;
    setState(() {});
  }

  @override
  void dispose() {
    webViewProvider.controller = null;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebViewProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () => willPop(provider),
          child: Scaffold(
            appBar: widget.showAppBar == '1'
                ? buildAppBar(context, provider)
                : null,
            body: provider.controller != null
                ? WebViewWidget(controller: provider.controller!)
                : null,
            // floatingActionButton: favoriteButton(provider),
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context, WebViewProvider provider) {
    return AppBar(
      title: bodyLargeText(AppConst.appName, context, maxLines: 1),
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () async {
            if (provider.controller != null &&
                !(await provider.controller!.canGoBack())) {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            } else {
              // ignore: use_build_context_synchronously
              MyDialogs.showPanaraConfirmDialog(context,
                  title: 'Leave page',
                  desc: 'Are you sure to leave the session?', onConfirm: () {
                Future.delayed(const Duration(milliseconds: 500),
                    () => Navigator.pop(context));
              });
            }
          },
          icon: const Icon(Icons.arrow_back_rounded)),
      elevation: 10,
      actions: provider.controller != null
          ? <Widget>[
              NavigationControls(webViewController: provider.controller!),
              SampleMenu(webViewController: provider.controller!),
            ]
          : null,
      bottom: provider.controller != null
          ? PreferredSize(
              preferredSize: const Size(double.maxFinite, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentUrl != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Row(
                            children: [
                              const Icon(Icons.lock, size: 10),
                              width5(),
                              Expanded(
                                  child: capText(currentUrl!, context,
                                      maxLines: 1)),
                              width5(),
                              GestureDetector(
                                  onTap: () => copyToClipboardAndShowToast(
                                      currentUrl!, context),
                                  child: const Icon(Icons.copy, size: 15)),
                              width5(),
                            ],
                          ),
                        ),
                        height5(),
                      ],
                    ),
                  if (loadingProgress > 0)
                    LinearProgressIndicator(value: loadingProgress / 100),
                ],
              ))
          : null,
    );
  }

  Widget favoriteButton(WebViewProvider provider) {
    return FloatingActionButton(
      onPressed: provider.controller != null
          ? () async {
              final String? url = await provider.controller?.currentUrl();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Favorite $url')),
                );
              }
            }
          : null,
      child: const Icon(Icons.favorite),
    );
  }
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
  doPostRequest,
  loadLocalFile,
  loadFlutterAsset,
  loadHtmlString,
  transparentBackground,
  setCookie,
}

class SampleMenu extends StatelessWidget {
  SampleMenu({
    super.key,
    required this.webViewController,
  });

  final WebViewController webViewController;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      key: const ValueKey<String>('ShowPopupMenu'),
      onSelected: (MenuOptions value) {
        switch (value) {
          case MenuOptions.showUserAgent:
            _onShowUserAgent();
            break;
          case MenuOptions.listCookies:
            _onListCookies(context);
            break;
          case MenuOptions.clearCookies:
            _onClearCookies(context);
            break;
          case MenuOptions.addToCache:
            _onAddToCache(context);
            break;
          case MenuOptions.listCache:
            _onListCache();
            break;
          case MenuOptions.clearCache:
            _onClearCache(context);
            break;
          case MenuOptions.navigationDelegate:
            _onNavigationDelegateExample();
            break;
          case MenuOptions.doPostRequest:
            _onDoPostRequest();
            break;
          case MenuOptions.loadLocalFile:
            _onLoadLocalFileExample();
            break;
          case MenuOptions.loadFlutterAsset:
            _onLoadFlutterAssetExample();
            break;
          case MenuOptions.loadHtmlString:
            _onLoadHtmlStringExample();
            break;
          case MenuOptions.transparentBackground:
            _onTransparentBackground();
            break;
          case MenuOptions.setCookie:
            _onSetCookie();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.showUserAgent,
          child: Text('Show user agent'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.listCookies,
          child: Text('List cookies'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCookies,
          child: Text('Clear cookies'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.addToCache,
          child: Text('Add to cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.listCache,
          child: Text('List cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCache,
          child: Text('Clear cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.navigationDelegate,
          child: Text('Navigation Delegate example'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.doPostRequest,
          child: Text('Post Request'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.loadHtmlString,
          child: Text('Load HTML string'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.loadLocalFile,
          child: Text('Load local file'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.loadFlutterAsset,
          child: Text('Load Flutter Asset'),
        ),
        const PopupMenuItem<MenuOptions>(
          key: ValueKey<String>('ShowTransparentBackgroundExample'),
          value: MenuOptions.transparentBackground,
          child: Text('Transparent background example'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.setCookie,
          child: Text('Set cookie'),
        ),
      ],
    );
  }

  Future<void> _onShowUserAgent() {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    return webViewController.runJavaScript(
      'Toaster.postMessage("User Agent: " + navigator.userAgent);',
    );
  }

  Future<void> _onListCookies(BuildContext context) async {
    final String cookies = await webViewController
        .runJavaScriptReturningResult('document.cookie') as String;
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Cookies:'),
            _getCookieList(cookies),
          ],
        ),
      ));
    }
  }

  Future<void> _onAddToCache(BuildContext context) async {
    await webViewController.runJavaScript(
      'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";',
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Added a test entry to cache.'),
      ));
    }
  }

  Future<void> _onListCache() {
    return webViewController.runJavaScript('caches.keys()'
        // ignore: missing_whitespace_between_adjacent_strings
        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
        '.then((caches) => Toaster.postMessage(caches))');
  }

  Future<void> _onClearCache(BuildContext context) async {
    await webViewController.clearCache();
    await webViewController.clearLocalStorage();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cache cleared.'),
      ));
    }
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  Future<void> _onNavigationDelegateExample() {
    final String contentBase64 = base64Encode(
      const Utf8Encoder().convert(kNavigationExamplePage),
    );
    return webViewController.loadRequest(
      Uri.parse('data:text/html;base64,$contentBase64'),
    );
  }

  Future<void> _onSetCookie() async {
    await cookieManager.setCookie(
      const WebViewCookie(
        name: 'foo',
        value: 'bar',
        domain: 'httpbin.org',
        path: '/anything',
      ),
    );
    await webViewController.loadRequest(Uri.parse(
      'https://httpbin.org/anything',
    ));
  }

  Future<void> _onDoPostRequest() {
    return webViewController.loadRequest(
      Uri.parse('https://httpbin.org/post'),
      method: LoadRequestMethod.post,
      headers: <String, String>{'foo': 'bar', 'Content-Type': 'text/plain'},
      body: Uint8List.fromList('Test Body'.codeUnits),
    );
  }

  Future<void> _onLoadLocalFileExample() async {
    final String pathToIndex = await _prepareLocalFile();
    await webViewController.loadFile(pathToIndex);
  }

  Future<void> _onLoadFlutterAssetExample() {
    return webViewController.loadFlutterAsset('assets/www/index.html');
  }

  Future<void> _onLoadHtmlStringExample() {
    return webViewController.loadHtmlString(kLocalExamplePage);
  }

  Future<void> _onTransparentBackground() {
    return webViewController.loadHtmlString(kTransparentBackgroundPage);
  }

  Widget _getCookieList(String cookies) {
    if (cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
        cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }

  static Future<String> _prepareLocalFile() async {
    final String tmpDir = (await getTemporaryDirectory()).path;
    final File indexFile = File(
        <String>{tmpDir, 'www', 'index.html'}.join(Platform.pathSeparator));

    await indexFile.create(recursive: true);
    await indexFile.writeAsString(kLocalExamplePage);

    return indexFile.path;
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: const Padding(
            padding: EdgeInsetsDirectional.all(8.0),
            child: Icon(Icons.arrow_back_ios, size: 14),
          ),
          onTap: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        GestureDetector(
          child: const Padding(
            padding: EdgeInsetsDirectional.all(8.0),
            child: Icon(Icons.arrow_forward_ios, size: 14),
          ),
          onTap: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        GestureDetector(
          child: const Padding(
            padding: EdgeInsetsDirectional.all(8.0),
            child: Icon(Icons.replay, size: 14),
          ),
          onTap: () => webViewController.reload(),
        ),
      ],
    );
  }
}
