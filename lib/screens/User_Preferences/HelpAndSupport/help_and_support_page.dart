import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:my_global_tools/functions/functions.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/color.dart';
import '../../BottomNav/dash_setting_page.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  _HelpAndSupportPageState createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        header: const MaterialClassicHeader(color: appLogoColor),
        onRefresh: _onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            buildSliverAppBar(context),
            SliverStickyHeader.builder(
              builder: (context, state) => Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: spaceDefault, vertical: 10),
                    prefixIcon: const Icon(Icons.search, size: 18),
                    hintText: 'Search here...',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            SliverStickyHeader.builder(
                builder: (context, state) => Container(
                      // margin: EdgeInsets.symmetric(horizontal: paddingDefault),
                      // height: 60.0,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        color: (state.isPinned
                                ? getTheme.colorScheme.onPrimary
                                : getTheme.colorScheme.onSecondary
                                    .withOpacity(0.01))
                            .withOpacity(1.0 - state.scrollPercentage),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingDefault,
                          vertical: paddingDefault * 2),
                      alignment: Alignment.centerLeft,
                      child: bodyLargeText('Frequent Questions', context,
                          fontWeight: FontWeight.bold),
                    ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: 170,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(paddingDefault),
                      children: [
                        ...List.generate(
                            9,
                            (index) => Container(
                                  width: getWidth * 0.7,
                                  margin: EdgeInsets.only(right: spaceDefault),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                ))
                      ],
                    ),
                  ),
                )),
            SliverToBoxAdapter(child: height20()),
            SliverStickyHeader.builder(
              builder: (context, state) => Container(
                // margin: EdgeInsets.symmetric(horizontal: paddingDefault),
                // height: 60.0,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  color: (state.isPinned
                          ? getTheme.colorScheme.onPrimary
                          : getTheme.colorScheme.onSecondary.withOpacity(0.01))
                      .withOpacity(1.0 - state.scrollPercentage),
                ),

                alignment: Alignment.centerLeft,
                child: ChipsChoice<int>.single(
                  value: tag,
                  onChanged: (val) => setState(() => tag = val),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: options,
                    value: (i, v) => i,
                    label: (i, v) => '$v (${Random().nextInt(100)})',
                  ),
                ),
              ),
              sliver: SliverList.separated(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {},
                    title: capText('#$index How can we help you?', context),
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 13),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 0),
              ),
            ),
            SliverToBoxAdapter(child: height20()),
          ],
        ),
      ),
      floatingActionButton: buildContactUsButton(),
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

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: titleLargeText('Help & Support', context),
      actions: const [ToggleBrightnessButton()],
    );
  }
}
