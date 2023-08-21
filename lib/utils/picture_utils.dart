import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:my_global_tools/constants/app_const.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/functions/functions.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:rive/rive.dart';
import 'package:shimmer/shimmer.dart';

import 'color.dart';

Widget assetSvg(String path,
        {BoxFit? fit,
        bool fullPath = false,
        Color? color,
        double? width,
        double? height}) =>
    SvgPicture.asset(
      fullPath ? path : 'assets/svg/$path',
      fit: fit ?? BoxFit.contain,
      color: color,
      width: width,
      height: height,
    );
Widget assetRive(String path, {BoxFit? fit, bool fullPath = false}) =>
    RiveAnimation.asset(
      fullPath ? path : 'assets/rive/$path',
      fit: fit ?? BoxFit.contain,
    );
LottieBuilder assetLottie(String path,
        {BoxFit? fit,
        bool fullPath = false,
        double? width,
        double? height,
        LottieDelegates? delegates}) =>
    Lottie.asset(
      fullPath ? path : 'assets/lottie/$path',
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      delegates: delegates,
    );

Widget assetImages(String path,
        {BoxFit? fit,
        bool fullPath = false,
        Color? color,
        double? width,
        double? height}) =>
    Image.asset(
      fullPath ? path : 'assets/images/$path',
      fit: fit ?? BoxFit.contain,
      color: color,
      width: width,
      height: height,
    );

ImageProvider assetImageProvider(String path,
        {BoxFit? fit, bool fullPath = false}) =>
    AssetImage(fullPath ? path : 'assets/images/$path');

ImageProvider netImageProvider(String path,
        {BoxFit? fit, Color? color, double? width, double? height}) =>
    NetworkImage(path);

CachedNetworkImage buildCachedNetworkImage(String image,
    {double? ph,
    double? pw,
    double? borderRadius,
    BoxFit? fit,
    bool fullPath = false,
    String? placeholder}) {
  return CachedNetworkImage(
    imageUrl: image,
    fit: fit ?? BoxFit.cover,
    imageBuilder: (context, image) => ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: image, fit: fit ?? BoxFit.cover)),
      ),
    ),
    placeholder: (context, url) => Center(
      child: SizedBox(
        height: ph ?? 50,
        width: pw ?? 100,
        child: Center(
            child: CircularProgressIndicator(
                color: appLogoColor.withOpacity(0.5))),
      ),
    ),
    errorWidget: (context, url, error) => ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Center(
          child: SizedBox(
              height: ph ?? 50,
              width: pw ?? 100,
              child: assetImages(placeholder ?? PNGAssets.appLogo))),
    ),
    cacheManager: CacheManager(Config("${AppConst.appName}_$image",
        stalePeriod: const Duration(days: 30))),
  );
}

enum ImageLoadingMode { per, size, shimmer }

Widget buildCachedImageWithLoading(
  String image, {
  double? h,
  double? w,
  BoxFit? fit,
  bool fullPath = false,
  bool showText = false,
  ImageLoadingMode loadingMode = ImageLoadingMode.per,
  Color loadingColor = Colors.red,
  String? placeholder,
}) {
  return SizedBox(
    height: h,
    width: w,
    child: FastCachedImage(
      url: image,
      fit: fit ?? BoxFit.contain,
      fadeInDuration: const Duration(seconds: 1),
      errorBuilder: (context, exception, stacktrace) {
        return Center(
            child: SizedBox(
                height: h ?? 70,
                width: w ?? 70,
                child: assetImages(placeholder ?? PNGAssets.appLogo)));
      },
      loadingBuilder: (context, progress) {
        bool isMb = (inKB(progress.totalBytes ?? 0)).abs() >= 1000;
        double per = (progress.progressPercentage.value) * 100;
        logD('${inKB(progress.totalBytes ?? 0)} isMb : $isMb');
        return progress.isDownloading
            ? Container(
                child: loadingMode != ImageLoadingMode.shimmer
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          if (progress.totalBytes != null)
                            Text(
                                loadingMode == ImageLoadingMode.per
                                    ? '${per.toStringAsFixed(0)}%'
                                    : loadingMode == ImageLoadingMode.size
                                        ? '${isMb ? inMB(progress.downloadedBytes).toStringAsFixed(1) : inKB(progress.downloadedBytes).toStringAsFixed(0)} / ${isMb ? inMB(progress.totalBytes ?? 0).toStringAsFixed(1) : inKB(progress.downloadedBytes).toStringAsFixed(0)} ${isMb ? "Mb" : 'kb'}'
                                        : '',
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 10)),
                          if (loadingMode == ImageLoadingMode.per)
                            SizedBox(
                                width: w ?? 40,
                                height: h ?? 40,
                                child: CircularProgressIndicator(
                                    color: loadingColor,
                                    value: progress.progressPercentage.value)),
                        ],
                      )
                    : Center(
                        child: Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.secondary,
                          highlightColor: Theme.of(context).colorScheme.primary,
                          child: const Text(
                            'Loading...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              )
            : const SizedBox.shrink();
      },
    ),
  );
}
