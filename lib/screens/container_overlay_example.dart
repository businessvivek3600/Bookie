import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_global_tools/providers/setting_provider.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/app_const.dart';
import '../utils/theme.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ContainerOverlayExample extends StatefulWidget {
  final GlobalKey<OnboardingState> onboardingKey = GlobalKey<OnboardingState>();

  ContainerOverlayExample({Key? key}) : super(key: key);

  @override
  _ContainerOverlayExampleState createState() =>
      _ContainerOverlayExampleState();
}

class _ContainerOverlayExampleState extends State<ContainerOverlayExample> {
  final GlobalKey closeKey = GlobalKey();
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    focusNodes = List<FocusNode>.generate(
      18,
      (int i) => FocusNode(debugLabel: 'Onboarding Focus Node $i'),
      growable: false,
    );
  }

  @override
  Widget build(BuildContext context) => Consumer<SettingProvider>(
        builder: (context, settingProvider, child) {
          return MaterialApp(
            themeMode: settingProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            title: AppConst.appName,
            debugShowCheckedModeBanner: false,
            locale: settingProvider.currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: _onBoardingListWidget(
                focusNodes: focusNodes, onboardingKey: widget.onboardingKey),
          );
        },
      );
}

class _onBoardingListWidget extends StatelessWidget {
  const _onBoardingListWidget({
    super.key,
    required this.onboardingKey,
    required this.focusNodes,
  });

  final GlobalKey<OnboardingState> onboardingKey;
  final List<FocusNode> focusNodes;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Onboarding(
      key: onboardingKey,
      autoSizeTexts: true,
      debugBoundaries: false,
      steps: <OnboardingStep>[
        OnboardingStep(
          focusNode: focusNodes[0],
          titleText: 'Tap anywhere to continue ',
          titleTextColor: Colors.black,
          bodyText: 'Tap anywhere to continue Tap anywhere to continue',
          labelBoxPadding: const EdgeInsets.all(16.0),
          labelBoxDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: theme.onPrimary),
          arrowPosition: ArrowPosition.autoVerticalCenter,
          hasArrow: true,
          hasLabelBox: true,
          fullscreen: true,
          overlayBehavior: HitTestBehavior.translucent,
          onTapCallback:
              (TapArea area, VoidCallback next, VoidCallback close) {},
          stepBuilder: (
            BuildContext context,
            OnboardingStepRenderInfo renderInfo,
          ) {
            return SizedBox(
              width: 200,
              child: Material(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        renderInfo.titleText,
                        // style: renderInfo.titleStyle,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/gif/info.gif',
                            width: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: AutoSizeText(
                              renderInfo.bodyText,
                              // style: renderInfo.bodyStyle,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: renderInfo.nextStep,
                            child: const Text('Next'),
                          ),
                          TextButton(
                            onPressed: renderInfo.close,
                            child: const Text('close'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        OnboardingStep(
          focusNode: focusNodes[1],
          titleText: 'left fab',
          bodyText: 'Tap to continue',
          shape: const CircleBorder(),
          fullscreen: false,
          overlayColor: Colors.blue.withOpacity(0.9),
          overlayShape: const CircleBorder(),
          hasLabelBox: true,
          labelBoxDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: const Color(0xFF1100FF),
          ),
          showPulseAnimation: true,
        ),
        OnboardingStep(
          focusNode: focusNodes[2],
          titleText: 'right fab',
          bodyText: 'Tap only here to increment',
          shape: const CircleBorder(),
          fullscreen: false,
          overlayColor: Colors.blue.withOpacity(0.9),
          overlayShape: const CircleBorder(),
          overlayBehavior: HitTestBehavior.deferToChild,
          showPulseAnimation: true,
        ),
        OnboardingStep(
          focusNode: focusNodes[3],
          titleText: 'Easy to customize Easy to customize',
          titleTextColor: Colors.greenAccent,
          titleTextStyle: const TextStyle(
            fontSize: 46.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
          ),
          bodyText:
              'Easy to customize Easy to customize Easy to customize Easy to customize',
          bodyTextColor: Colors.greenAccent,
          bodyTextStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
          overlayColor: Colors.red.withOpacity(0.9),
          labelBoxPadding: const EdgeInsets.all(16.0),
          labelBoxDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: const Color(0xFF1100FF),
            border: Border.all(
              color: const Color(0xFFE2FB05),
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          arrowPosition: ArrowPosition.autoVertical,
          hasArrow: true,
          hasLabelBox: true,
          textAlign: TextAlign.center,
        ),
        OnboardingStep(
          focusNode: focusNodes[4],
          titleText: 'Menu',
          bodyText: 'You can open menu from here',
          overlayColor: Colors.green.withOpacity(0.9),
          shape: const CircleBorder(),
          overlayBehavior: HitTestBehavior.translucent,
          onTapCallback: (
            TapArea area,
            VoidCallback next,
            VoidCallback close,
          ) {
            log('tap callback $area');
            if (area == TapArea.hole) {
              next();
            }
          },
        ),
        OnboardingStep(
          focusNode: focusNodes[5],
          titleText: 'Close menu',
          bodyText: 'Click here to close the drawer',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: const CircleBorder(),
          hasLabelBox: true,
          hasArrow: true,
          overlayBehavior: HitTestBehavior.translucent,
          margin: const EdgeInsets.all(0),
          onTapCallback: (
            TapArea area,
            VoidCallback next,
            VoidCallback close,
          ) {
            log('tap callback $area');
            if (area == TapArea.hole) {
              next();
            }
          },
        ),
        OnboardingStep(
          focusNode: focusNodes[6],
          titleText: 'Counter Value',
          bodyText: 'With automatic vertical positioning of the text',
          labelBoxPadding: const EdgeInsets.all(16.0),
          labelBoxDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: const Color(0xFF1100FF),
            border: Border.all(
              color: const Color(0xFFE2FB05),
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          arrowPosition: ArrowPosition.autoVertical,
          hasArrow: true,
          hasLabelBox: true,
        ),
        OnboardingStep(
          focusNode: focusNodes[7],
          titleText: "Or no widget at all! You're all done!",
          textAlign: TextAlign.center,
          bodyText: "Or no widget at all! You're all done!",
          margin: EdgeInsets.zero,
          labelBoxPadding: const EdgeInsets.all(8.0),
          // shape: const CircleBorder(),
          // overlayShape: const CircleBorder(),
          fullscreen: true,
        ),
        OnboardingStep(
          focusNode: focusNodes[8],
          titleText: 'Icon 1',
          shape: const CircleBorder(),
          bodyText: 'Icon 1Icon 1Icon 1Icon 1Icon 1Icon 1Icon 1Icon 1',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: const CircleBorder(),
        ),
        OnboardingStep(
          focusNode: focusNodes[9],
          titleText: 'Icon 2',
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          bodyText:
              'Icon 2Icon 2Icon 2Icon 2Icon 2Icon 2Icon 2Icon 2Icon 2Icon 2Icon 2Icon 2',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: const CircleBorder(),
        ),
        OnboardingStep(
          focusNode: focusNodes[10],
          titleText: 'Icon 3',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          bodyText:
              'Icon 3Icon 3Icon 3Icon 3Icon 3Icon 3Icon 3Icon 3Icon 3Icon 3Icon 3Icon 3Icon 3Icon 3',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: const CircleBorder(),
          hasArrow: true,
          hasLabelBox: true,
          labelBoxDecoration: BoxDecoration(color: Colors.orange.shade900),
          arrowPosition: ArrowPosition.autoVertical,
        ),
        OnboardingStep(
          focusNode: focusNodes[11],
          titleText: 'Icon 4',
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          bodyText:
              'Icon 4Icon 4Icon 4Icon 4Icon 4Icon 4Icon 4Icon 4Icon 4Icon 4Icon 4Icon 4',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: const CircleBorder(),
          hasArrow: true,
          hasLabelBox: true,
          labelBoxDecoration: const BoxDecoration(color: Colors.green),
          arrowPosition: ArrowPosition.autoVertical,
        ),
        OnboardingStep(
          focusNode: focusNodes[12],
          titleText: 'Icon 5',
          shape: const CircleBorder(),
          bodyText: 'Icon 5Icon 5Icon 5Icon 5Icon 5Icon 5Icon 5Icon 5Icon 5',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: const CircleBorder(),
        ),
        OnboardingStep(
          focusNode: focusNodes[13],
          titleText: 'No icon',
          bodyText: 'No iconNo iconNo iconNo iconNo iconNo iconNo iconNo ',
          fullscreen: true,
          overlayColor: Colors.black.withOpacity(0.8),
          hasArrow: true,
          hasLabelBox: true,
          labelBoxDecoration: const BoxDecoration(color: Colors.purple),
          arrowPosition: ArrowPosition.autoVertical,
        ),
        OnboardingStep(
          focusNode: focusNodes[14],
          titleText: 'Icon 7',
          shape: const CircleBorder(),
          bodyText: 'Icon 7Icon 7Icon 7Icon 7Icon ',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: const CircleBorder(),
        ),
        OnboardingStep(
          focusNode: focusNodes[15],
          titleText: 'Icon 8',
          shape: const CircleBorder(),
          bodyText: 'Icon 8Icon 8Icon 8Icon 8Icon 8Icon 8Icon ',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          hasArrow: true,
          hasLabelBox: true,
          labelBoxDecoration: BoxDecoration(color: Colors.cyan.shade900),
          arrowPosition: ArrowPosition.autoVertical,
        ),
        OnboardingStep(
          focusNode: focusNodes[16],
          titleText: 'Icon 9',
          shape: const CircleBorder(),
          bodyText: 'Icon 9Icon 9Icon 9Icon 9Icon ',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          hasArrow: true,
          hasLabelBox: true,
          labelBoxDecoration: BoxDecoration(
            color: Colors.pink.shade900,
          ),
          arrowPosition: ArrowPosition.autoVertical,
        ),
        OnboardingStep(
          focusNode: focusNodes[17],
          titleText: 'Icon 10',
          shape: const CircleBorder(),
          bodyText: 'Icon 10Icon 10Icon 10Icon 10Icon 10Icon 10Icon',
          fullscreen: false,
          overlayColor: Colors.black.withOpacity(0.8),
          overlayShape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ],
      onChanged: (int index) {
        if (index == 4) {
          // close the drawer
          // if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
          //   scaffoldKey.currentState?.openEndDrawer();
          // }
          // interrupt onboarding on specific step
          // widget.onboardingKey.currentState.hide();
        }
        final int? currentIndex =
            onboardingKey.currentState?.controller.currentIndex;

        print('currentIndex $currentIndex');
      },
      child: Home(focusNodes: focusNodes),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.focusNodes,
  }) : super(key: key);

  final List<FocusNode> focusNodes;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = 0;
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      final OnboardingState? onboarding = Onboarding.of(context);
      if (onboarding != null) {
        // onboarding.show();
        // onboarding.showFromIndex(3);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _increment(BuildContext context) {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          focusNode: widget.focusNodes[4],
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Focus(
          focusNode: widget.focusNodes[3],
          child: const Text('Super Long Title'),
        ),
        actions: [
          IconButton(
            // focusNode: widget.focusNodes[5],
            icon: const Icon(Icons.mic),
            onPressed: () {},
          ),
          IconButton(
            // focusNode: widget.focusNodes[5],
            icon: const Icon(Icons.subscript),
            onPressed: () {},
          ),
          IconButton(
            // focusNode: widget.focusNodes[5],
            icon: const Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Menu'),
            ),
            ListTile(
              focusNode: widget.focusNodes[5],
              title: const Text('Close menu'),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return index == 5
              ? Focus(
                  focusNode: widget.focusNodes[13],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Focus(
                        focusNode: widget.focusNodes[0],
                        child: TextButton(
                          child: const Text(
                              'You have pushed the button this many times:'),
                          onPressed: () {
                            print('do something');
                          },
                        ),
                      ),
                      Focus(
                        focusNode: widget.focusNodes[6],
                        child: Text(
                          '$_counter',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                )
              : ListTile(
                  leading: Focus(
                    focusNode: widget.focusNodes[index + 8],
                    child: const Icon(Icons.alarm),
                  ),
                  title: Text('Item ${index + 1}'),
                  trailing: Text('${index + 8}'),
                );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   focusNode: widget.focusNodes[1],
      //   onPressed: () {
      //     final OnboardingState? onboarding = Onboarding.of(context);
      //     if (onboarding != null) {
      //       onboarding.show();
      //     }
      //   },
      //   child: const Icon(Icons.add),
      // ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            FloatingActionButton(
              focusNode: widget.focusNodes[1],
              onPressed: () {
                final OnboardingState? onboarding = Onboarding.of(context);
                if (onboarding != null) {
                  onboarding.show();
                }
              },
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              focusNode: widget.focusNodes[2],
              onPressed: () {
                _increment(context);
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
