import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../route_management/route_path.dart';
import '../utils/sized_utils.dart';
import '../utils/text.dart';
import 'Onboardings/on_boarding_page.dart';

class ConcentricOnBoardingExample extends StatefulWidget {
  const ConcentricOnBoardingExample({Key? key}) : super(key: key);

  @override
  State<ConcentricOnBoardingExample> createState() =>
      _ConcentricOnBoardingExampleState();
}

class _ConcentricOnBoardingExampleState
    extends State<ConcentricOnBoardingExample> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final pages = [
      const PageData(
        icon: Icons.bubble_chart,
        title: "Local news\nstories",
        bgColor: Color(0xFF0043D0),
        textColor: Colors.white,
      ),
      const PageData(
        icon: Icons.format_size,
        title: "Choose your\ninterests",
        bgColor: Color(0xFFFDBFDD),
        textColor: Colors.white,
      ),
      const PageData(
        icon: Icons.hdr_weak,
        title: "Drag and\ndrop to move",
        bgColor: Color(0xFFFFFFFF),
      ),
      const PageData(
        icon: Icons.ac_unit,
        title: "Explore our app and\nRate it on ⭐️ Play Store",
        bgColor: Color(0xFF71F6AF),
        textColor: Colors.white,
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [

/*
          ConcentricPageView(
            colors: pages.map((p) => p.bgColor).toList(),
            pageOpacity: 1,

            radius: screenWidth * 0.1,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 1500),
            nextButtonBuilder: (context) => Padding(
              padding: const EdgeInsets.only(left: 3), // visual center
              child:
                  Icon(Icons.navigate_next_rounded, size: screenWidth * 0.08),
            ),
            itemCount: pages.length,
            opacityFactor: 0.5,
            scaleFactor: 0.2,
            verticalPosition: 0.85,
            direction: Axis.horizontal,
            // physics: NeverScrollableScrollPhysics(),
            onFinish: () => context.pop(),
            onChange: (i) {
              setState(() {
                currentIndex = i;
              });
            },
            itemBuilder: (index) {
              final page = pages[index % pages.length];
              return SafeArea(
                child: _Page(page: page),
              );
            },
          ),
*/
          /*Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: customProgress(
                length: pages.length,
                currentIndex: currentIndex,
                onPressed: () {}),
          ),*/
          Positioned(
            bottom: Get.height - 100,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                    onPressed: () {
                      showOnBoarding = false;
                      context.go(RoutePath.login);
                    },
                    child:
                        titleLargeText('Login', context, color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;

  const PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        space(10),
        _Image(
          page: page,
          size: perSize(25),
          iconSize: perSize(22),
        ),
        space(8),
        _Text(
          page: page,
          style: TextStyle(
            fontSize: perSize(3.6),
          ),
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    Key? key,
    required this.page,
    this.style,
  }) : super(key: key);

  final PageData page;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      page.title ?? '',
      style: TextStyle(
        // color: page.textColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'halter',
        letterSpacing: 0.0,
        fontSize: perSize(2.5),
        height: 1.2,
      ).merge(style),
      textAlign: TextAlign.center,
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
    required this.page,
    required this.size,
    required this.iconSize,
  }) : super(key: key);

  final PageData page;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final bgColor = page.bgColor
        // .withBlue(page.bgColor.blue - 40)
        .withGreen(page.bgColor.green + 20)
        .withRed(page.bgColor.red - 100)
        .withAlpha(90);

    final icon1Color =
        page.bgColor.withBlue(page.bgColor.blue - 10).withGreen(220);
    final icon2Color = page.bgColor.withGreen(66).withRed(77);
    final icon3Color = page.bgColor.withRed(111).withGreen(220);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
        color: bgColor,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            right: -5,
            bottom: -5,
            child: RotatedBox(
                quarterTurns: 2,
                child: Icon(page.icon, size: iconSize + 20, color: icon1Color)),
          ),
          Positioned.fill(
            child: RotatedBox(
                quarterTurns: 5,
                child: Icon(page.icon, size: iconSize + 20, color: icon2Color)),
          ),
          Icon(page.icon, size: iconSize, color: icon3Color),
        ],
      ),
    );
  }
}

//root code

class ConcentricPageView extends StatefulWidget {
  final Function(int index) itemBuilder;
  final Function(int page)? onChange;
  final Function? onFinish;
  final int? itemCount;
  final PageController? pageController;
  final bool pageSnapping;
  final bool reverse;
  final List<Color> colors;
  final ValueNotifier? notifier;
  final double scaleFactor;
  final double pageOpacity;
  final double opacityFactor;
  final double radius;
  final double verticalPosition;
  final Axis direction;
  final ScrollPhysics? physics;
  final Duration duration;
  final Curve curve;
  final Key? pageViewKey;

  /// Useful for adding a next icon to the page view button
  final WidgetBuilder? nextButtonBuilder;

  const ConcentricPageView({
    Key? key,
    required this.itemBuilder,
    required this.colors,
    this.pageViewKey,
    this.onChange,
    this.onFinish,
    this.itemCount,
    this.pageController,
    this.pageSnapping = true,
    this.reverse = false,
    this.notifier,
    this.scaleFactor = 0.3,
    this.opacityFactor = 0.0,
    this.radius = 40.0,
    this.verticalPosition = 0.75,
    this.direction = Axis.horizontal,
    this.physics = const ClampingScrollPhysics(),
    this.duration = const Duration(milliseconds: 1500),
    this.curve = Curves.easeInOutSine, // const Cubic(0.7, 0.5, 0.5, 0.1),
    this.nextButtonBuilder,
    this.pageOpacity = 1,
  })  : assert(colors.length >= 2),
        super(key: key);

  @override
  _ConcentricPageViewState createState() => _ConcentricPageViewState();
}

class _ConcentricPageViewState extends State<ConcentricPageView> {
  late PageController _pageController;
  double _progress = 0;
  int _prevPage = 0;
  Color? _prevColor;
  Color? _nextColor;

  @override
  void initState() {
    _prevColor = widget.colors[_prevPage];
    _nextColor = widget.colors[_prevPage + 1];
    _pageController = (widget.pageController ?? PageController(initialPage: 0))
      ..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        _buildClipper(),
        _buildPageView(),
        Positioned(
          top: MediaQuery.of(context).size.height * widget.verticalPosition,
          child: _Button(
            pageController: _pageController,
            widget: widget,
          ),
        ),
      ],
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      key: widget.pageViewKey,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
        overscroll: false,
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      clipBehavior: Clip.none,
      scrollDirection: widget.direction,
      controller: _pageController,
      reverse: widget.reverse,
      physics: widget.physics,
      itemCount: widget.itemCount,
      pageSnapping: widget.pageSnapping,
      onPageChanged: (int page) {
        if (widget.onChange != null) {
          widget.onChange!(page);
        }
      },
      itemBuilder: (context, index) {
        final child = widget.itemBuilder(index);
        if (!_pageController.position.hasContentDimensions) {
          return child;
        }
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            final progress = _pageController.page! - index;
            if (widget.opacityFactor != 0) {
              child = Opacity(
                opacity: (1 - (progress.abs() * widget.opacityFactor))
                    .clamp(0.0, 1.0),
                child: child,
              );
            }
            if (widget.scaleFactor != 0) {
              child = Transform.scale(
                scale:
                    (1 - (progress.abs() * widget.scaleFactor)).clamp(0.0, 1.0),
                child: child,
              );
            }
            return child!;
          },
          child: child,
        );
      },
    );
  }

  Widget _buildClipper() {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (ctx, _) {
        return ColoredBox(
          color: _prevColor!.withOpacity(0.05),
          child: ClipPath(
            clipper: ConcentricClipper(
              progress: _progress,
              reverse: widget.reverse,
              radius: widget.radius,
              verticalPosition: widget.verticalPosition,
            ),
            child: ColoredBox(
              color: _nextColor!.withOpacity(0.5),
              child: const SizedBox.expand(),
            ),
          ),
        );
      },
    );
  }

  void _onScroll() {
    final direction = _pageController.position.userScrollDirection;
    double page = _pageController.page ?? 0;

    if (direction == ScrollDirection.forward) {
      _prevPage = page.toInt();
      _progress = page - _prevPage;
    } else {
      _prevPage = page.toInt();
      _progress = page - _prevPage;
    }

    final total = widget.colors.length;
    final prevIndex = _prevPage % total;
    int nextIndex = prevIndex + 1;

    if (prevIndex == total - 1) {
      nextIndex = 0;
    }

    _prevColor = widget.colors[prevIndex];
    _nextColor = widget.colors[nextIndex];

    widget.notifier?.value = page - _prevPage;
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.pageController,
    required this.widget,
  }) : super(key: key);

  final PageController pageController;
  final ConcentricPageView widget;

  @override
  Widget build(BuildContext context) {
    final size = widget.radius * 2;
    Widget? child = widget.nextButtonBuilder != null
        ? widget.nextButtonBuilder!(context)
        : null;

    child = GestureDetector(
      excludeFromSemantics: true,
      onTap: () {
        final isFinal = pageController.page == widget.colors.length - 1;
        if (isFinal && widget.onFinish != null) {
          widget.onFinish!();
          return;
        }
        pageController.nextPage(
          duration: widget.duration,
          curve: widget.curve,
        );
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: SizedBox.fromSize(
          size: Size.square(size),
          child: child,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final currentPage = pageController.page?.floor() ?? 0;
        final progress = (pageController.page ?? 0) - currentPage;
        return AnimatedOpacity(
          opacity: progress > 0.01 ? 0.0 : 1.0,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 150),
          child: IconTheme(
            data: IconThemeData(
              color: widget.colors[currentPage % widget.colors.length],
            ),
            child: child!,
          ),
        );
      },
      child: child,
    );
  }
}

//clipper

class ConcentricClipper extends CustomClipper<Path> {
  final double radius;
  final double limit = 0.5;
  final double verticalPosition;
  final double progress;
  final double growFactor;
  final bool reverse;

  const ConcentricClipper({
    this.progress = 0.0,
    this.verticalPosition = 0.85,
    this.radius = 30.0,
    this.growFactor = 30.0,
    this.reverse = false,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    Rect shape;
    path.fillType = PathFillType.evenOdd;
    if (progress <= limit) {
      shape = _createGrowingShape(path, size);
    } else {
      shape = _createShrinkingShape(path, size);
    }
    path.addArc(shape, 0, 90);
    // path.addRect(rect);
    return path;
  }

  @override
  bool shouldReclip(ConcentricClipper oldClipper) {
    return progress != oldClipper.progress;
  }

  Rect _createGrowingShape(Path path, Size size) {
    double _progress = progress * growFactor;
    double _limit = limit * growFactor;
    double r = radius + pow(2, _progress);
    double delta = (1 - (_progress / _limit)) * radius;
    double x = (size.width / 2) + r - delta - 2.0;
    double y = (size.height * verticalPosition) + radius;

    if (reverse) {
      x *= -1;
    }

    return Rect.fromCircle(center: Offset(x, y), radius: r);
  }

  Rect _createShrinkingShape(Path path, Size size) {
    double _progress = (progress - limit) * growFactor;
    double _limit = limit * growFactor;
    double r = radius + pow(2, _limit - _progress);
    double delta = (_progress / _limit) * radius;
    double x = size.width / 2 - r + delta;
    double y = (size.height * verticalPosition) + radius;

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    if (reverse) {
      x *= -1;
    }

    return Rect.fromCircle(center: Offset(x, y), radius: r);
  }
}

//route

class ConcentricPageRoute<T> extends PageRoute<T> {
  ConcentricPageRoute({
    required this.builder,
    RouteSettings? settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog);

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  @override
  final bool maintainState;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 700);

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
    return previousRoute is ConcentricPageRoute;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    // Don't perform outgoing animation if the next route is a fullscreen dialog.
    return (nextRoute is ConcentricPageRoute && !nextRoute.fullscreenDialog);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget? result = builder(context);
    assert(() {
      if (result == null) {
        throw FlutterError(
            'The builder for route "${settings.name}" returned null.\n'
            'Route builders must never return null.');
      }
      return true;
    }());
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: result,
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    //    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return _FadeInPageTransition(routeAnimation: animation, child: child);
  }

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}

class _FadeInPageTransition extends StatelessWidget {
  _FadeInPageTransition({
    Key? key,
    required Animation<double>
        routeAnimation, // The route's linear 0.0 - 1.0 animation.
    required this.child,
  })  : _opacityAnimation = routeAnimation.drive(_easeInTween),
        super(key: key);

  // // Fractional offset from 1/4 screen below the top to fully on screen.
  // static final Tween<Offset> _bottomUpTween = Tween<Offset>(
  //   begin: const Offset(0.0, 0.25),
  //   end: Offset.zero,
  // );
  // static final Animatable<double> _fastOutSlowInTween =
  //     CurveTween(curve: Curves.fastOutSlowIn);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  final Animation<double> _opacityAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // return FadeTransition(
    //   opacity: _opacityAnimation,
    //   child: child,
    // );
    return ClipPath(
      clipper: ConcentricClipper(progress: _opacityAnimation.value),
      child: child,
    );
  }
}
