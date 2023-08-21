import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/user/user_data_model.dart';
import '../../services/auth_service.dart';

bool showOnBoarding = false;

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late PageController controller;
  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        4,
        (index) => Container(
              // decoration: BoxDecoration(color: Colors.grey.shade300),
              child: Column(
                children: [
                  Container(
                    height: getWidth,
                    // color: Color.fromRGBO(Random().nextInt(255),
                    //     Random().nextInt(255), Random().nextInt(255), 0.1),
                    child: assetImages('onBoarding3.png'),
                  ),
                  titleLargeText('OnBoarding#$index', context, fontSize: 22),
                  height20(),
                  bodyLargeText(
                      'A multi vendor ecommerce website is a platform where multiple sellers can sell their products or services. This type of marketplace is also sometimes called a "marketplace model" or "online marketplace". Some of the most popular examples of Multi Vendor ecommerce marketplaces are Amazon, eBay, and Etsy.',
                      context,
                      textAlign: TextAlign.center,maxLines: 10),
                ],
              ),
            ));

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            // key: widget.pageViewKey,
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
              overscroll: false,
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            controller: controller,
            reverse: false,
            physics: const ScrollPhysics(),
            itemCount: 4,
            pageSnapping: true,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  // final progress = controller.page! - index;

                  return pages[index];
                  return child!;
                },
              );
            },
          ),
          Positioned(
            bottom: Get.height - 70,
            right: 20,
            child: GestureDetector(
                onTap: () {
                  if (currentPage < pages.length - 1) {
                    controller.animateToPage(pages.length - 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn);
                    return;
                  }
                  showOnBoarding = false;
                  context.go(RoutePath.login);
                },
                child: bodyLargeText(
                    currentPage < pages.length - 1 ? 'Skip' : 'Login', context,
                    color: getTheme.colorScheme.primary)),
          ),
          Positioned(
              bottom: Get.height - 90,
              left: 10,
              child: const ToggleBrightnessButton()),
/*
          Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FilledButton(
                      onPressed: () {
                        showOnBoarding = false;
                        context.go(RoutePath.login);
                      },
                      child: titleLargeText('Login', context,
                          color: Colors.white)),
                ),
                width10(),
                Expanded(
                  child: FilledButton(
                      onPressed: () {
                        StreamAuthScope.of(context)
                            .signIn(UserData(status: '2'), onBoarding: false);
                        context.go(RoutePath.home);
                      },
                      child: titleLargeText('Get Started', context,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
*/
          Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey[300]!,
                    activeDotColor: getTheme.colorScheme.primary,
                    dotHeight: 12,
                    dotWidth: 12,
                    // type: WormType.thinUnderground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
