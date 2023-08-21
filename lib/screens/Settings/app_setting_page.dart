import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../route_management/route_animation.dart';
import '../../route_management/route_name.dart';
import '../../utils/text.dart';
import '/functions/functions.dart';
import '/utils/sized_utils.dart';
import '/widgets/custom_bottom_sheet_dialog.dart';
import '/widgets/app_language_change_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/setting_provider.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(getLang.settings),
          ),
          body: ListView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            children: [
              height5(),
              buildSettingTile(
                  context, Icons.notifications, 'Manage Notifications',
                  trailing: Icons.toggle_on_outlined, onTap: () {
                context.pushNamed(RouteName.notificationSettings,
                    queryParameters: {'animation': RouteTransition.fade.name});
              }),
              height5(),
              ListTile(
                // tileColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 16),
                title: Text(getLang.sound),
                trailing: const Icon(Icons.volume_up),
              ),
              height5(),
              ListTile(
                // tileColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 16),
                title: Text(getLang.darkMode),
                trailing: GestureDetector(
                    onTap: () => provider.setThemeMode(context),
                    child: Icon(provider.themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode)),
              ),
              height5(),
              ListTile(
                  // tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 16),
                  title: Row(children: [Text(getLang.language)]),
                  trailing: Container(
                    constraints: const BoxConstraints(maxWidth: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(provider.currentLanguage.name),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () => showLanguagePicker(context, provider)),

            ],
          ),
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
      trailing: Icon(trailing),
    );
  }

  void showLanguagePicker(BuildContext context, SettingProvider provider) =>
      CustomBottomSheet.show(
          context: context, builder: (_) => AppLanguageWidget());
}
