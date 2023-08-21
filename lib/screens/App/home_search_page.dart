import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_global_tools/utils/sized_utils.dart';

import '../../constants/asset_constants.dart';
import '../../utils/color.dart';
import '../../utils/picture_utils.dart';
import '../../utils/text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.query});
  final String? query;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
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
      _searchController.text = widget.query!;
    }
    _searchController.addListener(() {
      filterSearchResults(_searchController.text);
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
      _searchController.clear();
      filteredItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 10, vertical: 20),
        children: [
          buildCategories(context),
          buildBestServices(context, options),
          height100(),
        ],
      ),
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
                onPressed: () {},
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
              label: (i, v) => '$v (${Random().nextInt(100)})',
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
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 150, minWidth: 150),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: getTheme.colorScheme.onPrimary,
                                  blurRadius: 5,
                                  spreadRadius: 5),
                            ]),
                            child: LayoutBuilder(builder: (context, bound) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  assetImages(PNGAssets.appLogo,
                                      height: bound.maxHeight / 2,
                                      width: bound.maxWidth),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          bodyMedText('Shop Name', context,
                                              maxLines: 1),
                                          capText('Service name', context,
                                              maxLines: 1,
                                              color: getTheme
                                                  .textTheme.bodyMedium?.color
                                                  ?.withOpacity(0.5)),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  ),
                                                  width5(),
                                                  bodyMedText('4.5', context),
                                                ],
                                              ),
                                              Expanded(
                                                  child: bodyMedText(
                                                      '\$44/h', context,
                                                      textAlign:
                                                          TextAlign.end)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                          ),
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
                onPressed: () {},
                child: capText('See All', context,
                    color: getTheme.colorScheme.primary))
          ],
        ),
        Wrap(
          children: [
            ...List.generate(
                5,
                (index) => LayoutBuilder(builder: (context, bound) {
                      return Container(
                        constraints: BoxConstraints(
                            maxWidth: (getWidth - 40 - paddingDefault * 2) / 3,
                            minWidth: (getWidth - 40 - paddingDefault * 2) / 3),
                        margin: EdgeInsets.only(
                            right: index % 2 == 0 && index != 0 ? 0 : 10,
                            bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: generateRandomLightColor().withOpacity(0.2)),
                        child: Column(
                          children: [
                            assetImages(PNGAssets.appLogo),
                            capText('Category', context)
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: SizedBox(
        height: 35,
        child: TextFormField(
          controller: _searchController,
          style: const TextStyle(fontSize: 15),
          showCursor: true,
          autofocus: true,
          onChanged: (val) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Search...',
            contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: paddingDefault),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: clearSearch,
                    child: const Icon(CupertinoIcons.clear_circled_solid),
                  ),
                width10(),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus(); // Hide keyboard
                    filterSearchResults(_searchController.text);
                  },
                  child: const Icon(CupertinoIcons.search),
                ),
                width10(),
              ],
            ),
          ),
          textInputAction: TextInputAction.search,
          onSaved: (_) {
            FocusScope.of(context).unfocus(); // Hide keyboard
            filterSearchResults(_searchController.text);
          },
        ),
      ),
      actions: [width10(paddingDefault)],
    );
  }
}
