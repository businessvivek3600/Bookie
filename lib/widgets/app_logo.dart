import 'package:flutter/material.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';

class ShowAppLogo extends StatelessWidget {
  const ShowAppLogo(
      {super.key, this.image, this.h = 50, this.w = 100, this.expanded = true});
  final String? image;
  final double h;
  final double w;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  PreferredSize buildAppLogo(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(h),
      child: Column(
        children: [
          height10(),
          SizedBox(
              width: expanded ? getSize(context).width * 0.6 : w,
              child: buildCachedNetworkImage(image ?? '',
                  placeholder: PNGAssets.appLogo, ph: h, pw: w)),
        ],
      ),
    );
  }
}
