import 'dart:convert';

import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '/utils/date_utils.dart';
import '../BottomNav/dash_setting_page.dart';
import '/functions/functions.dart';
import '/utils/picture_utils.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/color.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isIconMode = true;
  int primaryAccount = 0;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isIconMode = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isIconMode = true;
        });
      }
    });
    readJson();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    await future(3000);
    _refreshController.refreshCompleted();
  }

  int tag = 1;
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];
  final menuDropdownController = DropdownController();

  List<dynamic> notifications = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/notifications.json');
    final data = await json.decode(response);

    setState(() {
      notifications = data['notifications']
          .map((data) => _InstagramNotification.fromJson(data))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        header: const MaterialClassicHeader(color: appLogoColor),
        onRefresh: _onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverList.separated(
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return index % 2 == 0
                    ? buildAccountsTile(index)
                    : notificationItem(notifications[index]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
            ),
            SliverToBoxAdapter(child: height20()),
          ],
        ),
      ),
    );
  }

  notificationItem(_InstagramNotification notification) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: paddingDefault, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                notification.hasStory
                    ? Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.red, Colors.orangeAccent],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomLeft),
                            // border: Border.all(color: Colors.red),
                            shape: BoxShape.circle),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: buildCachedNetworkImage(notification.profilePic)),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: buildCachedNetworkImage(notification.profilePic)),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: notification.name,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: notification.content,
                        style: const TextStyle(color: Colors.black)),
                    TextSpan(
                      text: notification.timeAgo,
                      style: TextStyle(color: Colors.grey.shade500),
                    )
                  ])),
                )
              ],
            ),
          ),
          notification.postImage != ''
              ? SizedBox(
                  width: 50,
                  height: 50,
                  child:
                      ClipRRect(child: buildCachedNetworkImage(notification.postImage)),
                )
              : Container(
                  height: 35,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                      child: Text('Follow',
                          style: TextStyle(color: Colors.white)))),
        ],
      ),
    );
  }

  Widget buildAccountsTile(int index) {
    return buildSlidableTile(
      index,
      child: Container(
        padding: EdgeInsets.all(paddingDefault),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index == 0
              ? getTheme.colorScheme.primary.withOpacity(0.05)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getWidth * 0.1,
              width: getWidth * 0.1,
              // decoration: const BoxDecoration(shape: BoxShape.circle),
              child: buildCachedNetworkImage(
                  'https://w7.pngwing.com/pngs/728/384/png-transparent-vadodara-bank-of-baroda-central-bank-of-india-online-banking-bank-angle-text-logo.png',
                  borderRadius: 50),
            ),
            width10(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bodyMedText('Get More Sales With Social Proof', context,
                      maxLines: 1),
                  capText(
                      'Cart abandonment is a serious problem for almost every eCommerce site under the sun. A quick notification can often nudge customers to buy something that they added to their cart and forgot about completely.',
                      context,
                      maxLines: 2),
                  height5(),
                  capText(
                      MyDateUtils.getTimeDifference(MyDateUtils.randomDate(40)),
                      context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Slidable buildSlidableTile(int index, {required Widget child}) {
    return Slidable(
        key: ValueKey(index.toString()),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dragDismissible: false,
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            // SlidableAction(
            //   onPressed: (ctx) {},
            //   backgroundColor: Colors.transparent,
            //   foregroundColor: Colors.red,
            //   icon: Icons.delete,
            //   label: 'Delete',
            // ),
            SlidableAction(
              // An action can be bigger than the others.
              // flex: 2,
              onPressed: (ctx) {},
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF7BC043),
              // icon: Icons.archive,
              label: 'Primary',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          openThreshold: 0.3,
          children: [
            SlidableAction(
                // An action can be bigger than the others.
                // flex: 2,
                onPressed: (ctx) {},
                backgroundColor: Colors.transparent,
                foregroundColor: getTheme.colorScheme.primary,
                icon: Icons.mode
                // label: 'Edit',
                ),
            SlidableAction(
              onPressed: (ctx) {},
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.red,
              icon: Icons.delete,
              // label: 'Delete',
            ),
          ],
        ),
        child: child);
  }

  AnimatedContainer buildContactUsButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // width: !_isIconMode ? 60.0 : 130.0,
      child: !_isIconMode
          ? FloatingActionButton(
              key: const Key('icon'),
              onPressed: () {},
              child: const Icon(Icons.messenger_outline_rounded),
            )
          : FloatingActionButton.extended(
              key: const Key('label'),
              onPressed: () {},
              label: const Text('Contact', style: TextStyle(fontSize: 14)),
              icon: const Icon(Icons.messenger_outline_rounded, size: 18),
            ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: titleLargeText('Notifications', context),
      actions: [
        const ToggleBrightnessButton(),
        /*       CoolDropdown<String>(
          controller: menuDropdownController,
          dropdownList: options
              .map((e) => CoolDropdownItem<String>(
                  label: e,
                  icon: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 25,
                    width: 25,
                    child: assetImages(PNGAssets.appLogo),
                  ),
                  selectedIcon: Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 25,
                      width: 25,
                      child: assetImages(PNGAssets.appLogo)),
                  value: e))
              .toList(),
          defaultItem: null,
          onChange: (value) async {
            if (menuDropdownController.isError) {
              await menuDropdownController.resetError();
            }
            // menuDropdownController.close();
          },
          onOpen: (value) {},
          resultOptions: const ResultOptions(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: 200,
            icon: SizedBox(
              width: 10,
              height: 10,
              child: CustomPaint(
                painter: DropdownArrowPainter(),
              ),
            ),
            render: ResultRender.all,
            placeholder: 'Select Fruit',
            isMarquee: true,
          ),
          dropdownOptions: const DropdownOptions(
              top: 20,
              height: 400,
              gap: DropdownGap.all(5),
              borderSide: BorderSide(width: 1, color: Colors.black),
              padding: EdgeInsets.symmetric(horizontal: 10),
              align: DropdownAlign.left,
              animationType: DropdownAnimationType.size),
          dropdownTriangleOptions: const DropdownTriangleOptions(
            width: 20,
            height: 30,
            align: DropdownTriangleAlign.left,
            borderRadius: 3,
            left: 20,
          ),
          dropdownItemOptions: const DropdownItemOptions(
            isMarquee: true,
            mainAxisAlignment: MainAxisAlignment.start,
            render: DropdownItemRender.all,
            height: 50,
          ),
        ),*/
        PopupMenuButton(
          onSelected: (item) async {},
          icon: const Icon(Icons.more_vert),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          itemBuilder: (BuildContext context) => ['select', 'mark all as read']
              .map((e) => PopupMenuItem(
                    child: capText(e, context),
                    padding: EdgeInsets.symmetric(horizontal: paddingDefault),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _InstagramNotification {
  final String name;
  final String profilePic;
  final String content;
  final String postImage;
  final String timeAgo;
  final bool hasStory;

  _InstagramNotification(this.name, this.profilePic, this.content,
      this.postImage, this.timeAgo, this.hasStory);

  factory _InstagramNotification.fromJson(Map<String, dynamic> json) {
    return new _InstagramNotification(json['name'], json['profilePic'],
        json['content'], json['postImage'], json['timeAgo'], json['hasStory']);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> notifications = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/notifications.json');
    final data = await json.decode(response);

    setState(() {
      notifications = data['notifications']
          .map((data) => _InstagramNotification.fromJson(data))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Activity",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Slidable(
                // actionPane: SlidableDrawerActionPane(),
                // actionExtentRatio: 0.25,
                child: notificationItem(notifications[index]),
                /* endActionPane: <Widget>[
                  Container(
                      height: 60,
                      color: Colors.grey.shade500,
                      child: Icon(Icons.info_outline, color: Colors.white,)
                  ),
                  Container(
                      height: 60,
                      color: Colors.red,
                      child: Icon(Icons.delete_outline_sharp, color: Colors.white,)
                  ),
                ],*/
              );
            }));
  }

  notificationItem(_InstagramNotification notification) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                notification.hasStory
                    ? Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.red, Colors.orangeAccent],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomLeft),
                            // border: Border.all(color: Colors.red),
                            shape: BoxShape.circle),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(notification.profilePic)),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(notification.profilePic)),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: notification.name,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: notification.content,
                        style: const TextStyle(color: Colors.black)),
                    TextSpan(
                      text: notification.timeAgo,
                      style: TextStyle(color: Colors.grey.shade500),
                    )
                  ])),
                )
              ],
            ),
          ),
          notification.postImage != ''
              ? SizedBox(
                  width: 50,
                  height: 50,
                  child:
                      ClipRRect(child: Image.network(notification.postImage)),
                )
              : Container(
                  height: 35,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                      child: Text('Follow',
                          style: TextStyle(color: Colors.white)))),
        ],
      ),
    );
  }
}
