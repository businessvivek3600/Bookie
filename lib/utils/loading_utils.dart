import 'package:flutter/material.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/utils/picture_utils.dart';

showLoading(BuildContext context, {bool? userRootNavigator}) async {
  var size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    useRootNavigator: userRootNavigator ?? false,
    barrierDismissible: false,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Colors.transparent,
        margin:EdgeInsetsDirectional.symmetric(
            horizontal: size.width * 0.2, vertical: size.height * 0.3),
        child: Center(child: assetRive(RiveAssets.appDefaultLoading)),
      ),
    ),
  );
}

appDefaultPlainLoading({double? height, double? width}) =>
    Builder(builder: (context) {
      var size = MediaQuery.of(context).size;
      return Container(
          color: Colors.transparent,
          height: height ?? size.width * 0.5,
          width: width ?? size.height * 0.5,
          child: Center(child: assetRive(RiveAssets.appDefaultLoading)));
    });

appLoadingDots({double? height, double? width}) => Builder(builder: (context) {
      var size = MediaQuery.of(context).size;
      return Container(
          color: Colors.transparent,
          height: height ?? size.width * 0.3,
          width: width ?? size.height * 0.3,
          child: Center(child: assetRive(RiveAssets.loadingDots)));
    });
