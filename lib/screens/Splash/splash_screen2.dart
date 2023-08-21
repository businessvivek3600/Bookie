import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/functions/functions.dart';
import 'package:my_global_tools/route_management/route_name.dart';
import 'package:my_global_tools/utils/picture_utils.dart';

import '../../utils/sp_utils.dart';
import '../Onboardings/on_boarding_page.dart';


class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return DemoHelper(demoType: DemoType.fadeIn);
  }
}

enum DemoType {
  custom,
  gif,
  fadeIn,
  scale,
  dynamicNextScreenFadeIn,
  usingBackgroundImage,
  usingGradient,
}

// ignore: must_be_immutable
class DemoHelper extends StatefulWidget {
  DemoHelper({super.key, required this.demoType});

  DemoType demoType;

  @override
  State<DemoHelper> createState() => _DemoHelperState();
}

class _DemoHelperState extends State<DemoHelper> {
  @override
  Widget build(BuildContext context) {
    switch (widget.demoType) {
      case DemoType.gif:
        return FlutterSplashScreen.gif(
          gifPath: 'assets/gif/success.gif',
          gifWidth: 269,
          gifHeight: 474,
          duration: const Duration(milliseconds: 3515),
          onInit: () async {
            await Future.delayed(const Duration(milliseconds: 2000));
          },
          onEnd: () async {
            showOnBoarding = SpUtils().showOnBoarding;
            context.goNamed(RouteName.home);
          },
        );
      case DemoType.fadeIn:
        return FlutterSplashScreen.fadeIn(
          backgroundColor: Colors.white,
          onInit: () async{
            debugPrint("On Init");
            await future(3000);
          },
          // childWidget: assetImages(PNGAssets.appLogo),
          // childWidget: assetImages(PNGAssets.appLogo),
          childWidget: assetLottie('loading.json'),
          onAnimationEnd: () => debugPrint("On Fade In End"),
          onEnd: () async {
            showOnBoarding = SpUtils().showOnBoarding;
            context.goNamed(RouteName.home);
          },
        );
      case DemoType.scale:
        return FlutterSplashScreen.scale(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue,
              Colors.blue,
            ],
          ),
          onInit: () {
            debugPrint("On Init");
          },
          onEnd: () async {
            showOnBoarding = SpUtils().showOnBoarding;
            context.goNamed(RouteName.home);
          },
          childWidget: assetImages(PNGAssets.appLogo),
          duration: const Duration(milliseconds: 1500),
          animationDuration: const Duration(milliseconds: 1000),
          onAnimationEnd: () => debugPrint("On Scale End"),
        );
      case DemoType.usingBackgroundImage:
        return FlutterSplashScreen.fadeIn(
          backgroundImage: Image.asset('assets/images/${PNGAssets.appLogo}',
              fit: BoxFit.contain),
          childWidget: SizedBox(
              height: 100, width: 100, child: assetImages(PNGAssets.appLogo)),
          onEnd: () async {
            showOnBoarding = SpUtils().showOnBoarding;
            context.goNamed(RouteName.home);
          },
        );
      case DemoType.usingGradient:
        return FlutterSplashScreen.fadeIn(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFF6972), Color(0xffFE6770)],
          ),
          childWidget: SizedBox(
            height: 100,
            width: 100,
            child: Image.asset('assets/gif/success.gif'),
          ),
          onEnd: () async {
            showOnBoarding = SpUtils().showOnBoarding;
            context.goNamed(RouteName.home);
          },
        );
      case DemoType.dynamicNextScreenFadeIn:
        return FlutterSplashScreen.fadeIn(
          backgroundColor: Colors.white,
          childWidget: assetImages(PNGAssets.appLogo),
          onAnimationEnd: () => debugPrint("On Fade In End"),
          onEnd: () async {
            showOnBoarding = SpUtils().showOnBoarding;
            context.goNamed(RouteName.home);
          },
        );
      case DemoType.custom:
        return FlutterSplashScreen(
          duration: const Duration(milliseconds: 2000),
          backgroundColor: Colors.white,
          splashScreenBody: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Text("Custom Splash",
                    style: TextStyle(color: Colors.black, fontSize: 24)),
                Spacer(),
                FlutterLogo(size: 200),
                Spacer(),
                Text("Flutter is Love",
                    style: TextStyle(color: Colors.pink, fontSize: 20)),
                SizedBox(height: 100),
              ],
            ),
          ),
          onEnd: () async {
            showOnBoarding = SpUtils().showOnBoarding;
            context.goNamed(RouteName.home);
          },
        );
      default:
        return Container();
    }
  }
}

//root code
enum SplashType {
  custom,
  gif,
  fadeIn,
  scale,
}

// ignore: must_be_immutable
class GifSplash extends StatefulWidget {
  GifSplash({super.key});

  Color? backgroundColor;

  String? gifPath;

  double? gifWidth;

  double? gifHeight;

  Image? backgroundImage;

  Gradient? gradient;

  @override
  State<GifSplash> createState() => _GifSplashState();
}

class _GifSplashState extends State<GifSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          image: widget.backgroundImage != null
              ? DecorationImage(image: widget.backgroundImage!.image)
              : null,
          gradient: widget.gradient,
        ),
        child: Center(
          child: SizedBox(
            width: widget.gifWidth,
            height: widget.gifHeight,
            child: Image.asset(widget.gifPath!),
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: file_names

// ignore: must_be_immutable
class FadeInSplash extends StatefulWidget {
  FadeInSplash({super.key});

  Color? backgroundColor;

  double opacity = 0;

  VoidCallback? onFadeInEnd;

  Widget? fadeInChildWidget;

  Duration? fadeInAnimationDuration;

  Curve? animationCurve = Curves.ease;

  Image? backgroundImage;

  Gradient? gradient;

  @override
  State<FadeInSplash> createState() => _FadeInSplashState();
}

class _FadeInSplashState extends State<FadeInSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          image: widget.backgroundImage != null
              ? DecorationImage(
                  image: widget.backgroundImage!.image,
                  fit: BoxFit.fill,
                )
              : null,
          gradient: widget.gradient,
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: widget.opacity,
            curve: widget.animationCurve!,
            onEnd: widget.onFadeInEnd,
            duration: widget.fadeInAnimationDuration!,
            child: widget.fadeInChildWidget,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ScaleSplash extends StatefulWidget {
  ScaleSplash({super.key});

  Color? backgroundColor;

  double scale = 0;

  VoidCallback? onScaleEnd;

  Widget? scaleChildWidget;

  Duration? scaleAnimationDuration;

  Curve? animationCurve = Curves.ease;

  Image? backgroundImage;

  Gradient? gradient;

  @override
  State<ScaleSplash> createState() => _ScaleSplashState();
}

class _ScaleSplashState extends State<ScaleSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          image: widget.backgroundImage != null
              ? DecorationImage(
                  image: widget.backgroundImage!.image,
                  fit: BoxFit.fill,
                )
              : null,
          gradient: widget.gradient,
        ),
        child: Center(
          child: AnimatedScale(
            curve: widget.animationCurve!,
            onEnd: widget.onScaleEnd,
            duration: widget.scaleAnimationDuration!,
            scale: widget.scale,
            child: widget.scaleChildWidget,
          ),
        ),
      ),
    );
  }
}

typedef SetNextScreenAsyncCallback = Future<Widget> Function();

// ignore: must_be_immutable
class FlutterSplashScreen extends StatefulWidget {
  FlutterSplashScreen({
    Key? key,
    this.duration = const Duration(milliseconds: 3000),
    this.backgroundColor = Colors.black,
    this.splashScreenBody,
    // required this.defaultNextScreen,
    this.setStateTimer = const Duration(milliseconds: 100),
    this.setStateCallback,
    this.onInit,
    this.onEnd,
    // this.setNextScreenAsyncCallback,
  }) : super(key: key);

  Duration duration;

  Color? backgroundColor;

  Widget? splashScreenBody;

  // Widget? defaultNextScreen;

  // SetNextScreenAsyncCallback? setNextScreenAsyncCallback;

  Duration setStateTimer;

  VoidCallback? setStateCallback;

  VoidCallback? onInit;

  VoidCallback? onEnd;

  String? gifPath;

  double? gifWidth;

  double? gifHeight;

  double _opacity = 0;

  double _scale = 0;

  VoidCallback? onAnimationEnd;

  Widget? childWidget;

  Duration? animationDuration;

  SplashType splashType = SplashType.custom;

  Curve animationCurve = Curves.ease;

  Image? backgroundImage;

  Gradient? gradient;

  @override
  State<FlutterSplashScreen> createState() => _FlutterSplashScreenState();

  /// Provides ready-made gif templated splash;
  FlutterSplashScreen.gif({
    super.key,
    required this.gifPath,
    required this.gifWidth,
    required this.gifHeight,
    // required this.defaultNextScreen,
    this.duration = const Duration(milliseconds: 3000),
    this.backgroundColor = Colors.black,
    this.setStateTimer = const Duration(milliseconds: 100),
    this.setStateCallback,
    this.onInit,
    this.onEnd,
    // this.setNextScreenAsyncCallback,
    this.backgroundImage,
    this.gradient,
  }) {
    splashType = SplashType.gif;
  }

  /// Provides ready-made fadeIn templated splash;
  FlutterSplashScreen.fadeIn({
    super.key,
    // required this.defaultNextScreen,
    required this.childWidget,
    this.animationCurve = Curves.ease,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.duration = const Duration(milliseconds: 3000),
    this.backgroundColor = Colors.black,
    this.setStateTimer = const Duration(milliseconds: 200),
    this.onAnimationEnd,
    this.onInit,
    this.onEnd,
    // this.setNextScreenAsyncCallback,
    this.backgroundImage,
    this.gradient,
  }) {
    splashType = SplashType.fadeIn;

    setStateCallback = () {
      _opacity = 1;
    };
  }

  /// Provides ready-made fadeIn templated splash;
  FlutterSplashScreen.scale({
    super.key,
    // required this.defaultNextScreen,
    required this.childWidget,
    this.animationCurve = Curves.ease,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.duration = const Duration(milliseconds: 3000),
    this.backgroundColor = Colors.black,
    this.setStateTimer = const Duration(milliseconds: 200),
    this.onAnimationEnd,
    this.onInit,
    this.onEnd,
    // this.setNextScreenAsyncCallback,
    this.backgroundImage,
    this.gradient,
  }) {
    splashType = SplashType.scale;

    setStateCallback = () {
      _scale = 1;
    };
  }
}

class _FlutterSplashScreenState extends State<FlutterSplashScreen> {
  @override
  void initState() {
    super.initState();

    widget.onInit?.call();

/*
    if (widget.setNextScreenAsyncCallback != null) {
      widget.setNextScreenAsyncCallback
          ?.call()
          .then((value) => widget.defaultNextScreen = value);
    }
*/

    Future.delayed(widget.setStateTimer, () {
      if (mounted) {
        widget.setStateCallback?.call();
        setState(() {});
      }
    });

    Future.delayed(widget.duration, () {
      widget.onEnd?.call();
      /* Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return widget.defaultNextScreen ?? Container();
          },
        ),
      );*/
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.splashType == SplashType.gif) {
      return GifSplash()
        ..backgroundColor = widget.backgroundColor
        ..gifPath = widget.gifPath
        ..gifHeight = widget.gifHeight
        ..gifWidth = widget.gifWidth
        ..backgroundImage = widget.backgroundImage
        ..gradient = widget.gradient;
    } else if (widget.splashType == SplashType.fadeIn) {
      return FadeInSplash()
        ..opacity = widget._opacity
        ..backgroundColor = widget.backgroundColor
        ..onFadeInEnd = widget.onAnimationEnd
        ..fadeInChildWidget = widget.childWidget
        ..fadeInAnimationDuration = widget.animationDuration
        ..animationCurve = widget.animationCurve
        ..backgroundImage = widget.backgroundImage
        ..gradient = widget.gradient;
    } else if (widget.splashType == SplashType.scale) {
      return ScaleSplash()
        ..scale = widget._scale
        ..backgroundColor = widget.backgroundColor
        ..onScaleEnd = widget.onAnimationEnd
        ..scaleChildWidget = widget.childWidget
        ..scaleAnimationDuration = widget.animationDuration
        ..animationCurve = widget.animationCurve
        ..backgroundImage = widget.backgroundImage
        ..gradient = widget.gradient;
    } else {
      return Scaffold(
        backgroundColor: widget.backgroundColor,
        body: widget.splashScreenBody,
      );
    }
  }
}
