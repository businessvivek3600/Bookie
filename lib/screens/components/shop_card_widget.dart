import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/asset_constants.dart';
import '../../route_management/route_name.dart';
import '../../utils/picture_utils.dart';
import '../../utils/sized_utils.dart';
import '../../utils/text.dart';


class ShopCard extends StatelessWidget {
  const ShopCard({
    super.key,
    required this.index,
    this.applyBound = false,
  });

  final int index;
  final bool applyBound;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .pushNamed(RouteName.shop, queryParameters: {'shop': 'Shop Random'}),
      child: Container(
        constraints: applyBound
            ? const BoxConstraints(maxWidth: 150, minWidth: 150)
            : null,
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
                  height: bound.maxHeight / 2, width: bound.maxWidth),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bodyMedText('Shop Name', context, maxLines: 1),
                      capText('Category', context, maxLines: 1),
                      capText('0.2 km', context,
                          maxLines: 1, color: Colors.red.withOpacity(0.7)),
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
                              child: bodyMedText('\$44/h', context,
                                  textAlign: TextAlign.end)),
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
    );
  }
}
