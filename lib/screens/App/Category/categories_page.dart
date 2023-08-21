import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../route_management/route_name.dart';
import '../../../utils/default_logger.dart';
import '../../../widgets/animate_searchbar_widget.dart';
import '../../components/service_card_widget.dart';
import '/utils/sized_utils.dart';

import '../../../constants/asset_constants.dart';
import '../../../utils/color.dart';
import '../../../utils/picture_utils.dart';
import '../../../utils/text.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key, this.query});
  final String? query;
  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: titleLargeText(searchClosed ? 'All Categories' : '', context),
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
      body: GridView.builder(
        padding: EdgeInsets.all(paddingDefault * 2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust the number of columns here
        ),
        itemCount: 20, // Replace with the actual number of items
        itemBuilder: (context, index) {
          return GridTile(
            child: GestureDetector(
              onTap: () => context.pushNamed(RouteName.categoryDetail),
              child: Container(
                margin: EdgeInsets.only(
                    right: index % 2 == 1 && index != 0 ? 0 : 10, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: generateRandomLightColor().withOpacity(0.2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    assetImages(PNGAssets.appLogo),
                    capText('Categor', context)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
