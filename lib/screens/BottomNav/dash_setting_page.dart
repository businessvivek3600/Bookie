import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/constants/app_const.dart';
import 'package:my_global_tools/functions/functions.dart';
import 'package:my_global_tools/route_management/route_name.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/setting_provider.dart';
import '../../repo_injection.dart';
import '../../route_management/route_animation.dart';
import '../../services/auth_service.dart';
import '../../utils/default_logger.dart';
import '../../widgets/buttonStyle.dart';
import '../../widgets/custom_bottom_sheet_dialog.dart';
import '../../widgets/social_login_buttons.dart';

class DashSettingPage extends StatefulWidget {
  const DashSettingPage({super.key});

  @override
  State<DashSettingPage> createState() => _DashSettingPageState();
}

class _DashSettingPageState extends State<DashSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dashProvider, child) {
        return Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Consumer<SettingProvider>(
              builder: (context, settingProvider, child) {
                return Scaffold(
                  appBar: buildAppBar(context),
                  body: ListView(
                    padding: EdgeInsets.symmetric(horizontal: paddingDefault),
                    children: [
                      buildUserCard(context),
                      height10(spaceDefault),
                      buildCategoryCard(context, 'Personal Information', [
                        buildSettingTile(context, Icons.person, 'My Profile',
                            onTap: () => context.pushNamed(RouteName.profile,
                                    queryParameters: {
                                      'animation':
                                          RouteTransition.fromBottom.name
                                    })),
                        buildSettingTile(
                            context, Icons.location_city, 'Address',
                            onTap: () => context.pushNamed(
                                    RouteName.addressMainPage,
                                    queryParameters: {
                                      'animation':
                                          RouteTransition.fromBottom.name,
                                      'title': null,
                                      'selectionMode': '0',
                                    })),
                        buildSettingTile(
                            context, Icons.credit_card, 'Payment Methods',
                            onTap: () => context.pushNamed(
                                    RouteName.paymentMethodsPage,
                                    queryParameters: {
                                      'animation':
                                          RouteTransition.fromBottom.name
                                    })),
                      ]),
                      height10(spaceDefault),
                      buildCategoryCard(context, 'Preferences', [
                        buildSettingTile(
                            context, Icons.settings, 'App Settings', onTap: () {
                          context.pushNamed(RouteName.appSetting);
                        }),
                        buildSettingTile(context, Icons.help, 'Help & Support',
                            onTap: () => context.pushNamed(
                                    RouteName.helpAndSupportPage,
                                    queryParameters: {
                                      'animation':
                                          RouteTransition.fromBottom.name
                                    })),
                        buildSettingTile(
                            context, Icons.rule, 'Terms & Conditions',
                            onTap: () {}),
                        buildSettingTile(context, Icons.privacy_tip_outlined,
                            'Privacy Policy',
                            onTap: () {}),
                        buildSettingTile(
                            context, Icons.poll_outlined, 'Refund Policy',
                            onTap: () {}),
                      ]),
                      height10(spaceDefault),
                      buildCategoryCard(context, 'Others', [
                        buildSettingTile(
                            context, Icons.info_outline_rounded, 'About Us',
                            onTap: () {}),
                        buildSettingTile(
                            context, Icons.share, 'Share ${AppConst.appName}',
                            onTap: () => shareApp()),
                        buildSettingTile(
                            context, Icons.star_border_sharp, 'Rate Us',
                            leadingColor: Colors.amber, onTap: () {}),
                        buildSettingTile(context, Icons.logout, 'Logout',
                            leadingColor: Colors.red, onTap: () async {
                          bool? logout = await CustomBottomSheet.show<bool>(
                            context: context,
                            // backgroundColor: Colors.transparent,
                            showCloseIcon: false,
                            curve: Curves.bounceIn,
                            builder: (context) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                titleLargeText(
                                    'Do you really want to logout?', context),
                                const Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FilledButton(
                                        style: buttonStyle(
                                            bgColor: Colors.transparent),
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: bodyMedText('Cancel', context,
                                            color: Colors.red),
                                      ),
                                    ),
                                    width10(),
                                    Expanded(
                                      child: FilledButton(
                                        // style:
                                        //     buttonStyle(bgColor: Colors.green),
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: bodyMedText('Confirm', context,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                          logD('will pop scope $logout');
                          if (logout != null && logout) {
                            // final StreamAuth info = StreamAuthScope.of(context);
                            StreamAuthScope.of(context).signOut();
                          }
                        }),
                      ]),
                      height50(),
                      height30(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: paddingDefault),
                        child: Column(
                          children: [
                            bodyMedText('App Version: 1.0.0', context),
                            height10(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.scale(
                                    scale: 0.8,
                                    child: FlutterSocialButton(
                                      onTap: () {},
                                      mini: true,
                                      buttonType: ButtonType.facebook,
                                    )),
                                Transform.scale(
                                    scale: 0.8,
                                    child: FlutterSocialButton(
                                      onTap: () {},
                                      mini: true,
                                      buttonType: ButtonType.twitter,
                                    )),
                                Transform.scale(
                                    scale: 0.8,
                                    child: FlutterSocialButton(
                                      onTap: () {},
                                      mini: true,
                                      buttonType: ButtonType.whatsapp,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      height50(),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  ListTile buildSettingTile(
      BuildContext context, IconData leading, String title,
      {IconData trailing = Icons.arrow_forward_ios_rounded,
      Color? leadingColor,
      required VoidCallback onTap}) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      splashColor: Theme.of(context).colorScheme.onSecondary,
      onTap: onTap,
      leading: Icon(leading,
          color: leadingColor ??
              Theme.of(context).colorScheme.primary.withOpacity(0.8)),
      title: bodyMedText(title, context),
      trailing: Icon(trailing, size: 15),
    );
  }

  Card buildCategoryCard(
      BuildContext context, String name, List<Widget> tiles) {
    return Card(
      elevation: 0.5,
      child: Container(
        // padding: EdgeInsets.all(paddingDefault),
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(paddingDefault * 2),
              child: bodyLargeText(name, context),
            ),
            const Divider(height: 0),
            ...tiles.map((tile) {
              int index = tiles.indexOf(tile);
              return Column(
                children: [
                  tile,
                  if (index < tiles.length - 1) const MySeparator(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Card buildUserCard(BuildContext context) {
    return Card(
      elevation: 0.5,

      // color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
      child: Container(
        padding: EdgeInsets.all(paddingDefault),
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            CircleAvatar(
              radius: getWidth * 0.08,
              backgroundImage: const NetworkImage(
                  'https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png'),
            ),
            width10(),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                bodyLargeText('Chandan Kumar Singh', context),
                bodyMedText('+91 9135324545', context),
              ],
            )),
            width10(),
            GestureDetector(
              onTap: () async {
                infoLog('data');
                await showDialog<void>(
                  context: context,
                  // barrierColor: Colors.transparent,
                  barrierDismissible: true,
                  builder: (BuildContext dialogContext) {
                    return Center(
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Card(
                          child: Container(
                            height: getWidth * 0.9,
                            width: getWidth * 0.8,
                            padding: EdgeInsets.all(paddingDefault * 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: buildCachedNetworkImage(
                                      'https://i.pinimg.com/1200x/5e/da/c1/5edac14e5942bc0cadc41774b53dd36b.jpg',
                                      fit: BoxFit.contain,
                                      borderRadius: 10),
                                ),
                                height10(),
                                bodyMedText('Tap to close', context)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: getWidth * 0.2,
                  width: getWidth * 0.2,
                  child: buildCachedNetworkImage(
                      'https://i.pinimg.com/1200x/5e/da/c1/5edac14e5942bc0cadc41774b53dd36b.jpg',
                      fit: BoxFit.cover),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: titleLargeText('Settings', context),
      actions: [
        IconButton(
            onPressed: () => context.pushNamed(RouteName.notificationPage,
                    queryParameters: {
                      'animation': RouteTransition.fromBottom.name
                    }),
            icon: const Badge(child: Icon(Icons.notifications_outlined))),
        IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_outline)),
        const ToggleBrightnessButton()
      ],
    );
  }
}

class ToggleBrightnessButton extends StatelessWidget {
  const ToggleBrightnessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, settingProvider, child) {
        return IconButton(
            onPressed: () => settingProvider.setThemeMode(context),
            icon: Icon(settingProvider.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode));
      },
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color, this.width = 2})
      : super(key: key);
  final double height;
  final double width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: color ??
                        Theme.of(context).dividerColor.withOpacity(0.3)),
              ),
            );
          }),
        );
      },
    );
  }
}
