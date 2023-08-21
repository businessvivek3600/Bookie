import 'dart:math';

import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../repo_injection.dart';
import '../components/shop_card_widget.dart';
import '/constants/asset_constants.dart';
import '/route_management/route_animation.dart';
import '/route_management/route_name.dart';
import '/screens/components/service_card_widget.dart';
import '/utils/color.dart';
import '/utils/picture_utils.dart';
import 'package:random_avatar/random_avatar.dart';
import '/functions/functions.dart';
import '/providers/auth_provider.dart';
import '/providers/dashboard_provider.dart';
import '/providers/setting_provider.dart';
import '/route_management/route_path.dart';
import '/screens/chat/ChatPageExample.dart';
import '/screens/send_mail_page.dart';
import '/utils/default_logger.dart';
import '/utils/my_toasts.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elegant_notification/resources/arrays.dart';
import '/utils/sized_utils.dart';
import '/widgets/activity_list_widget.dart';
import '/widgets/custom_bottom_sheet_dialog.dart';
import '/widgets/MultiStageButton.dart';
import '/widgets/FadeScaleTransitionWidget.dart';
import '/widgets/buttonStyle.dart';
import '/widgets/custom_steps_and_pages.dart';
import '/widgets/dialogs_page.dart';
import '/providers/connectivity_provider.dart';
import '/utils/my_advanved_toasts.dart';
import '/utils/text.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../CachedMediaFileExamplePage.dart';
import '../FastCacheNetworkImageExamplePage.dart';
import '../concentric_onboarding.dart';
import '../container_overlay_example.dart';
import '../container_overlay_example2.dart';
import '../container_overlay_example3.dart';
import '../time_line_page/time_line_main_page.dart';

class DashHomePage extends StatefulWidget {
  DashHomePage({super.key});

  @override
  State<DashHomePage> createState() => _DashHomePageState();
}

class _DashHomePageState extends State<DashHomePage> {
  int tag = 1;
  final _dashProvider = sl.get<DashboardProvider>();
  @override
  void initState() {
    super.initState();
    _dashProvider.scrollController.addListener(_dashProvider.onScroll);
  }

  @override
  void dispose() {
    _dashProvider.scrollController.removeListener(_dashProvider.onScroll);
    // _dashProvider.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StreamAuth info = StreamAuthScope.of(context);
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Consumer<SettingProvider>(
          builder: (context, settingProvider, child) {
            return Scaffold(
              body: CustomScrollView(
                controller:
                    Provider.of<DashboardProvider>(context, listen: true)
                        .scrollController,
                slivers: [
                  buildAppBar(info, settingProvider, context),
                  SliverToBoxAdapter(child: buildBody(authProvider)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Consumer<ConnectivityProvider> buildBody(AuthProvider authProvider) {
    List<String> options = [
      'sub-cat',
      'sub-cat',
      'sub-cat',
      'sub-cat',
      'sub-cat',
      'sub-cat',
      'sub-cat',
      'sub-cat',
      'sub-cat',
      'sub-cat',
      'sub-cat',
    ];
    return Consumer<ConnectivityProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10, vertical: 20),
          child: Column(
            children: [
              const _SliderWidget(),
              heightDefault(),
              buildCategories(context),
              buildBestShops(context, options),
              buildBestServices(context, options),
              height100(),
              // buildDemoColumn(provider, context, authProvider),
            ],
          ),
        );
      },
    );
  }

  Column buildBestServices(BuildContext context, List<String> options) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bodyLargeText('Best Services Near You', context),
            TextButton(
                onPressed: () => context.pushNamed(RouteName.services,
                        queryParameters: {
                          'animation': RouteTransition.fromBottom.name,
                          'service': 'saloon'
                        }),
                child: capText('See All', context,
                    color: getTheme.colorScheme.primary))
          ],
        ),
        Container(
          height: 35.0,
          decoration: const BoxDecoration(),
          alignment: Alignment.centerLeft,
          child: ChipsChoice<int>.single(
            padding: EdgeInsets.zero,
            value: tag,
            onChanged: (val) => setState(() => tag = val),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options,
              value: (i, v) => i,
              label: (i, v) => '$v $i (${Random().nextInt(100)})',
            ),
            choiceStyle: C2ChipStyle.toned(
                foregroundStyle: const TextStyle(fontSize: 10)),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            padding: EdgeInsets.all(paddingDefault),
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                  12,
                  (index) => Padding(
                        padding: EdgeInsets.only(right: paddingDefault),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ServiceCard(index: index, applyBound: true),
                        ),
                      ))
            ],
          ),
        )
      ],
    );
  }

  Column buildBestShops(BuildContext context, List<String> options) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bodyLargeText('Best Shops Near You', context),
            TextButton(
                onPressed: () => context.pushNamed(RouteName.services,
                        queryParameters: {
                          'animation': RouteTransition.fromBottom.name,
                          'service': 'saloon'
                        }),
                child: capText('See All', context,
                    color: getTheme.colorScheme.primary))
          ],
        ),
        Container(
          height: 35.0,
          decoration: const BoxDecoration(),
          alignment: Alignment.centerLeft,
          child: ChipsChoice<int>.single(
            padding: EdgeInsets.zero,
            value: tag,
            onChanged: (val) => setState(() => tag = val),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options,
              value: (i, v) => i,
              label: (i, v) => '$v $i (${Random().nextInt(100)})',
            ),
            choiceStyle: C2ChipStyle.toned(
                foregroundStyle: const TextStyle(fontSize: 10)),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            padding: EdgeInsets.all(paddingDefault),
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                  12,
                  (index) => Padding(
                        padding: EdgeInsets.only(right: paddingDefault),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ShopCard(index: index, applyBound: true),
                        ),
                      ))
            ],
          ),
        )
      ],
    );
  }

  Column buildCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bodyLargeText('Categories', context),
            TextButton(
                onPressed: () =>
                    context.pushNamed(RouteName.categories, queryParameters: {
                      'animation': RouteTransition.fromBottom.name,
                    }),
                child: capText('See All', context,
                    color: getTheme.colorScheme.primary))
          ],
        ),
        Wrap(
          children: [
            ...List.generate(
                5,
                (index) => LayoutBuilder(builder: (context, bound) {
                      return GestureDetector(
                        onTap: () =>
                            context.pushNamed(RouteName.categoryDetail),
                        child: Column(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      (getWidth - 40 - paddingDefault * 2) / 3,
                                  minWidth:
                                      (getWidth - 40 - paddingDefault * 2) / 3),
                              margin: EdgeInsets.only(
                                  right: index % 2 == 0 && index != 0 ? 0 : 10,
                                  bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.circle,
                                  color: generateRandomLightColor()
                                      .withOpacity(0.2)),
                              child: assetImages(PNGAssets.appLogo),
                            ),
                            capText('Category', context),
                            height5(),
                          ],
                        ),
                      );
                    }))
          ],
        )
        // SizedBox(
        //   height: 300,
        //   child: GridView.builder(
        //       shrinkWrap: true,
        //       gridDelegate:
        //           const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3,
        //         crossAxisSpacing: 10,
        //         mainAxisSpacing: 10,
        //       ),
        //       itemBuilder: (context, index) {
        //         return LayoutBuilder(builder: (context, bound) {
        //           return Container(
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(10),
        //                 color: getTheme.colorScheme.primary
        //                     .withOpacity(0.03)),
        //             child: Column(
        //               children: [
        //                 assetImages(PNGAssets.appLogo),
        //                 capText('Category', context)
        //               ],
        //             ),
        //           );
        //         });
        //       }),
        // )
      ],
    );
  }

  SliverAppBar buildAppBar(
      StreamAuth info, SettingProvider settingProvider, BuildContext context) {
    return SliverAppBar(
      // title: Text(getLang.helloWorld),
      expandedHeight: 120,
      pinned: true,
      title: Row(
        children: [
          CircleAvatar(
              child: RandomAvatar(
            DateTime.now().toIso8601String(),
            height: 50,
            width: 52,
          )),
          width10(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleLargeText(getLang.helloWorld, context),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: Colors.greenAccent, size: 15),
                    capText('Mohali,Punjab', context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (!Provider.of<DashboardProvider>(context, listen: true)
            .showTextField)
          IconButton(
              onPressed: () => goToHomeSearch(),
              icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () => settingProvider.setThemeMode(context),
            icon: Icon(settingProvider.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode)),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  goToHomeSearch();
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  child: bodyMedText(
                    'Search service or shops here...',
                    context,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void goToHomeSearch() {
  Get.context!.pushNamed(RouteName.search, queryParameters: {
    'animation': RouteTransition.fromBottom.name,
    'query': "apple"
  });
}

class _SliderWidget extends StatefulWidget {
  const _SliderWidget({super.key});

  @override
  State<_SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<_SliderWidget> {
  int currentIndex = 0;
  late PageController controller;
  final CarouselController _controller = CarouselController();
  setIndex(int index, CarouselPageChangedReason reason) =>
      setState(() => currentIndex = index);
  @override
  void initState() {
    controller = PageController(initialPage: 0);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      buildCachedNetworkImage(item, fit: BoxFit.cover),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();
    return Stack(
      children: [
        Container(
            constraints: const BoxConstraints(
                maxHeight: 120, maxWidth: 500, minWidth: 400, minHeight: 100),
            child: CarouselSlider(
              options: CarouselOptions(
                  // height: Get.height * 0.15,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: setIndex),
              items: imageSliders,
            )),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, getTheme.secondaryHeaderColor],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: getTheme.colorScheme.primary.withOpacity(
                            currentIndex == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

//demos

Column buildDemoColumn(ConnectivityProvider provider, BuildContext context,
    AuthProvider authProvider) {
  return Column(
    children: [
      Center(
        child: Text(
          provider.getOnline ? 'Online' : 'Offline',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      TextFormField(),
      FilledButton(
          onPressed: () => Toasts.warningBanner(),
          child: const Icon(Icons.add)),
      FilledButton(
        onPressed: () => Toasts.showAwesomeToast(context,
            title: 'title',
            content: 'content',
            contentType: ContentType.success,
            asBanner: true),
        child: const Icon(Icons.add_a_photo),
      ),
      FilledButton(
        onPressed: () => context
            .showToast(MyToastModel(ToastType.failed.name, ToastType.success)),
        child: const Icon(Icons.add_a_photo),
      ),
      bodyLargeText('Elegant Notifications', context),
      MyCustomAnimatedWidget(
        child: FilledButton(
          onPressed: () => AdvanceToasts.showNormalElegant(
              context, 'An elegant notification to display important',
              showProgressIndicator: false,
              notificationType: NotificationType.success),
          child: const Icon(Icons.animation),
        ),
      ),
      FilledButton(
        onPressed: () => AdvanceToasts.showNormalElegant(
            context, 'An elegant notification to display important',
            showProgressIndicator: false,
            notificationType: NotificationType.info),
        child: const Icon(Icons.add_a_photo),
      ),
      FilledButton(
        onPressed: () => AdvanceToasts.showNormalElegant(
            context, 'An elegant notification to display important',
            aDuration: 300,
            tDuration: 7000,
            action: linkifyText(
                'Contact Us: https://www.mycarclub.com/refCode?sponsor=tds'),
            onActionPressed: () =>
                logD('https://www.mycarclub.com/refCode?sponsor=tds'),
            notificationType: NotificationType.error),
        child: const Icon(Icons.add_a_photo),
      ),
      FilledButton(
        onPressed: () => AdvanceToasts.showNormalElegant(context,
            'An elegant notification to display important messages to users',
            showProgressIndicator: false,
            showLeading: false,
            showTrailing: false),
        child: const Icon(Icons.add_a_photo),
      ),
      FilledButton(
        onPressed: () => AdvanceToasts.showNormalElegant(
            context, 'An elegant notification to display important',
            // aDuration: 300,
            // tDuration: 7000,
            // action: linkifyText(
            //     'https://www.mycarclub.com/refCode?sponsor=tds'),
            // onActionPressed: () => log(
            //     'https://www.mycarclub.com/refCode?sponsor=tds'),
            // showLeading: false,
            // showTrailing: false,
            showProgressIndicator: false,
            notificationType: NotificationType.error),
        child: const Icon(Icons.add_a_photo),
      ),
      const Divider(),
      bodyLargeText('Dialogs', context),
      FilledButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const DialogPage())),
        child: const Icon(Icons.add_a_photo),
      ),
      const Divider(),
      bodyLargeText('Web View', context),
      FilledButton(
        onPressed: () => context.goNamed(RoutePath.explore, queryParameters: {
          'url': 'https://vimeo.com/event/3582236/embed',
          'showAppBar': '1',
          'showToast': '0',
          'changeOrientation': '0',
        }),
        child: const Icon(Icons.map_sharp),
      ),
      const Divider(),
      /*GestureDetector(
                onTap: () =>
                    context.goNamed(RoutePath.explore, queryParameters: {
                  'url': 'https://vimeo.com/event/3582236/embed',
                  'showAppBar': '0',
                  'changeOrientation': '1',
                  'showToast': '0',
                }),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: Get.width * 0.5,
                    child: Stack(
                      children: [
                        const WebViewExample(
                          url: 'https://vimeo.com/event/3582236/embed',
                          showAppBar: '0',
                          changeOrientation: '0',
                          showToast: '0',
                        ),
                        Container(
                          color: Colors.transparent,
                          width: double.maxFinite,
                          height: double.maxFinite,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),*/
      bodyLargeText('Multi Stage Button', context),
      Row(
        children: [
          Expanded(
            child: MultiStageButton(
                // idleIcon: const Icon(Icons.start,color: Colors.black),
                // completedIcon: SizedBox(
                //     height: 30,
                //     width: 30,
                //     child: assetRive(RiveAssets.successDone)),
                loadingText: 'Loading...',
                buttonLoadingState: authProvider.loginStatus,
                // idleColor: Colors.white,
                // completedColor: Colors.white,
                // failColor: Colors.white,
                // idleTextColor: Colors.black,
                // failTextColor: Colors.red,
                // completedTextColor: Colors.green,
                helperText: authProvider.errorText,
                onPressed: () => authProvider.login(status: false)),
          ),
        ],
      ),
      const Divider(),
      bodyLargeText('Bottom Sheets', context),
      FilledButton(
          onPressed: () => showCustomBottomSheet(context),
          child: const Text('Custom Bottom Sheet')),
      const Divider(),
      bodyLargeText('Multi Step Widget', context),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MultiStepWidget())),
        child: const Text('Multi Step Widget'),
      ),
      const Divider(),
      bodyLargeText('Custom Activity Widget', context),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const CustomActivityList())),
        child: const Text('Multi Step Widget'),
      ),
      const Divider(),
      bodyLargeText('My TimeLine App', context),
      FilledButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const MyTimeLineApp())),
        child: const Text('My TimeLine App'),
      ),
      const Divider(),
      bodyLargeText('Container Overlay Example', context),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => ContainerOverlayExample())),
        child: const Text('Container Overlay Example'),
      ),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MyShowcaseViewApp())),
        child: const Text('Container Overlay Example 2'),
      ),
      FilledButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MyTutorialCoachMarkPage())),
        child: const Text('Container Overlay Example 3'),
      ),
      const Divider(),
      bodyLargeText('Concentric OnBoarding Example', context),
      FilledButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const ConcentricOnBoardingExample())),
        child: const Text('Concentric OnBoarding Example'),
      ),
      const Divider(),
      bodyLargeText('OnBoarding Screen Package', context),
      FilledButton(
        onPressed: () {},
        child: const Text('flutter_overboard: ^3.1.1'),
      ),
      const Divider(),
      bodyLargeText('Chat App Example', context),
      FilledButton(
        onPressed: () {
          Get.to(const ChatScreen());
        },
        child: const Text('Chat App Example'),
      ),
      const Divider(),
      bodyLargeText('Fast Cache NetworkImage ExamplePage', context),
      FilledButton(
        onPressed: () {
          Get.to(const FastCacheNetworkImageExamplePage());
        },
        child: const Text('Fast Cache Network Image ExamplePage'),
      ),
      const Divider(),
      bodyLargeText('Cached Media File ExamplePage', context),
      FilledButton(
        onPressed: () {
          Get.to(const CachedMediaFileExamplePage());
        },
        child: const Text('Cached Media File ExamplePage'),
      ),
      const Divider(),
      bodyLargeText('Email Sender Page ExamplePage', context),
      FilledButton(
        onPressed: () {
          Get.to(const EmailSenderPage());
        },
        child: const Text('Email Sender Page ExamplePage'),
      ),
      height100(),
    ],
  );
}

void showCustomBottomSheet(BuildContext context) {
  CustomBottomSheet.show(
    context: context,
    curve: Curves.bounceIn,
    duration: 200,
    dismissible: false,
    onDismiss: () async {
      bool? willPop = await CustomBottomSheet.show<bool>(
        context: context,
        // backgroundColor: Colors.transparent,
        showCloseIcon: false,
        curve: Curves.bounceIn,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: buttonStyle(bgColor: Colors.green),
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: buttonStyle(bgColor: Colors.red),
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      logD('will pop scope $willPop');
      return willPop ?? false;
    },
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Custom Bottom Sheet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const FlutterLogo(size: 100),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      );
    },
  );
}
