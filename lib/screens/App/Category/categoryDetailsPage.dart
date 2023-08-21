import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/text.dart';

import '../../../constants/asset_constants.dart';
import '../../../route_management/route_animation.dart';
import '../../../route_management/route_name.dart';
import '../../../utils/color.dart';
import '../../../utils/sized_utils.dart';

class CategoryDetailsPage extends StatelessWidget {
  const CategoryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleLargeText('Category Name', context),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Handle share action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shop banner
            Container(
              height: 200,
              width: double.maxFinite,
              child: buildCachedNetworkImage(
                  'https://static.vecteezy.com/system/resources/thumbnails/002/229/347/small/hairdressing-salon-flat-color-illustration-man-cutting-beard-hairdresser-washing-woman-s-hair-artist-apply-make-up-stylists-2d-cartoon-characters-with-beauty-salon-furniture-on-background-vector.jpg',
                  fit: BoxFit
                      .cover), // Replace with actual banner image or color
            ),

            // Categories
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Add category widgets here

            // Popular services
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bodyLargeText('We delivers your favourites', context),
                  height20(),
                  Wrap(
                    children: [
                      ...List.generate(
                          13,
                          (index) => LayoutBuilder(builder: (context, bound) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => context.pushNamed(
                                          RouteName.services,
                                          queryParameters: {
                                            'animation':
                                                RouteTransition.fromBottom.name,
                                            'service': 'Sub-Categ $index'
                                          }),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: (getWidth -
                                                    40 -
                                                    paddingDefault * 2) /
                                                3,
                                            minWidth: (getWidth -
                                                    40 -
                                                    paddingDefault * 2) /
                                                3),
                                        margin: EdgeInsets.only(
                                            right: index % 2 == 0 && index != 0
                                                ? 0
                                                : 10,
                                            bottom: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            // borderRadius: BorderRadius.circular(10),
                                            color: generateRandomLightColor()
                                                .withOpacity(0.2)),
                                        child: assetImages(PNGAssets.appLogo),
                                      ),
                                    ),
                                    capText('Sub-Categ $index', context),
                                    height10(),
                                  ],
                                );
                              }))
                    ],
                  )
                ],
              ),
            ),
            // Add popular service tiles here

            // Description
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Description of the shop goes here...\nBarber Shop Signage Images – Browse 9,025 Stock Photos, Vectors, and Video | Adobe Stock Get this image on: Adobe Stock | Licence details Want to know where this information comes from? Learn more',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
