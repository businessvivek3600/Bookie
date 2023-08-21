import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import '../../../route_management/route_animation.dart';
import '../../../route_management/route_name.dart';
import '../../../widgets/animate_searchbar_widget.dart';
import '../../components/service_card_widget.dart';
import '../../components/shop_card_widget.dart';
import '/utils/sized_utils.dart';

import '../../../utils/text.dart';

class AllServicesPage extends StatefulWidget {
  const AllServicesPage({super.key, this.query, this.category});
  final String? query;
  final String? category;
  @override
  State<AllServicesPage> createState() => _AllServicesPageState();
}

class _AllServicesPageState extends State<AllServicesPage> {
  final searchController = TextEditingController();
  bool searchClosed = true;
  List<String> items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grapes',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Pear',
    'Quince',
    'Raspberry',
    'Strawberry',
    'Watermelon',
  ];
  List<String> filteredItems = [];
  int tag = 1;
  @override
  void initState() {
    super.initState();
    if (widget.query != null) {
      searchController.text = widget.query!;
    }
    searchController.addListener(() {
      filterSearchResults(searchController.text);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if (widget.query != null && widget.query!.isNotEmpty) {
          searchClosed = false;
        } else {
          searchClosed = true;
        }
      });
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredItems = items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      filteredItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        title: titleLargeText(
            searchClosed
                ? (searchController.text.isNotEmpty
                        ? searchController.text
                        : 'All Services')
                    .capitalize!
                : '',
            context),
        automaticallyImplyLeading: searchClosed,
        actions: [
          AnimSearchBar(
            width: getWidth,
            boxShadow: false,
            autoFocus: true,
            textController: searchController,
            onSuffixTap: (int? val) {
              infoLog('onSuffixTap $val');
              setState(() {
                searchController.clear();
                if (val != null && val == 0) {
                  searchClosed = true;
                }
              });
            },
            onBack: (int? val) {
              infoLog('onBack $val');
              setState(() {
                // searchController.clear();
                if (val != null && val == 0) {
                  searchClosed = true;
                }
              });
            },
            onSubmitted: (String val) {},
            searchBarOpen: (int val) {
              infoLog('searchBarOpen $val');
              setState(() {
                if (val == 1) {
                  searchClosed = false;
                } else {
                  searchClosed = true;
                }
              });
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverStickyHeader.builder(
            builder: (context, state) => ChipsChoice<int>.single(
              value: tag,
              onChanged: (val) => setState(() => tag = val),
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => '$v (${Random().nextInt(100)})',
              ),
              choiceStyle: C2ChipStyle.toned(
                  foregroundStyle: const TextStyle(fontSize: 10)),
            ),
          ),
          SliverStickyHeader.builder(
            builder: (context, state) => Container(
              padding: EdgeInsets.symmetric(horizontal: spaceDefault,vertical: paddingDefault),
              decoration: BoxDecoration(
                color: (state.isPinned
                        ? getTheme.colorScheme.onPrimary
                        : getTheme.colorScheme.onSecondary.withOpacity(0.01))
                    .withOpacity(1.0 - state.scrollPercentage),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bodyLargeText('Shops Near You', context),
                ],
              ),
            ),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
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
              ),
            ),
          ),
          SliverStickyHeader.builder(
            builder: (context, state) => Container(
              padding: EdgeInsets.symmetric(horizontal: spaceDefault,vertical: paddingDefault),
              decoration: BoxDecoration(
                color: (state.isPinned
                        ? getTheme.colorScheme.onPrimary
                        : getTheme.colorScheme.onSecondary.withOpacity(0.01))
                    .withOpacity(1.0 - state.scrollPercentage),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bodyLargeText('Services', context),
                ],
              ),
            ),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: Get.height - 200 - kTextTabBarHeight,
                child: GridView.builder(
                  padding: EdgeInsets.all(paddingDefault * 2),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: 20, // Replace with the actual number of items
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ServiceCard(index: index),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildBestShops(BuildContext context) {
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
}
