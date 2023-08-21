import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';

/// The not found screen
class NotFoundScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const NotFoundScreen({super.key, required this.uri, required this.state});
  final GoRouterState state;

  /// The uri that can not be found.
  final String uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            height5(kToolbarHeight),
            Expanded(child: assetLottie(LottieAssets.pageNotFound)),
            height20(),
            titleLargeText('Page not found', context, color: Colors.red),
            height5(),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16.0),
              child: bodyLargeText(
                  'Sorry, the data you are looking for not matched in our record',
                  context,
                  textAlign: TextAlign.center),
            ),
            height20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go(RoutePath.home);
                      }

                      infoLog(context.canPop().toString());
                      infoLog(state.location.toString());
                      infoLog(state.fullPath.toString());
                      infoLog(state.pageKey.toString());
                      // context.pop();
                    },
                    child: const Text('Go Back'))
              ],
            ),
            height100(Get.height * 0.1),
          ],
        ),
      ),
    );
  }
}
