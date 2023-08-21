import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:media_cache_manager/media_cache_manager.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';

import '../constants/app_const.dart';
import '../providers/setting_provider.dart';
import '../repo_injection.dart';
import '../utils/theme.dart';
import 'route_management/my_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String shortcut = 'no action set';
  initializeServices() async {
    FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
    MediaCacheManager.instance.init(
      // encryptionPassword: 'I love flutter',
      daysToExpire: 1,
    );

    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        shortcut = shortcutType;
      });
      errorLog(shortcut,'MyApp','QuickActions');
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      // NOTE: This first action icon will only work on iOS.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
        type: 'action_one',
        localizedTitle: 'Action one',
        icon: 'launcher_icon',
      ),
      // NOTE: This second action icon will only work on Android.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
          type: 'action_two',
          localizedTitle: 'Action two',
          icon: 'ic_launcher'),
    ]).then((void _) {
      setState(() {
        if (shortcut == 'no action set') {
          shortcut = 'actions ready';
        }
      });
    });

  }



  @override
  void initState() {
    super.initState();
    initializeServices();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: getNotifiers,
        child: Consumer<SettingProvider>(
          builder: (context, settingProvider, child) {
            return Builder(builder: (context) {
              return MaterialApp.router(
                routerDelegate: MyRouter.router.routerDelegate,
                routeInformationProvider:
                    MyRouter.router.routeInformationProvider,
                routeInformationParser: MyRouter.router.routeInformationParser,
                themeMode: Provider.of<SettingProvider>(context, listen: true)
                    .themeMode,
                theme: lightTheme,
                darkTheme: darkTheme,
                title: AppConst.appName,
                debugShowCheckedModeBanner: false,
                locale: settingProvider.currentLocale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            });
          },
        ),
      );
}
