
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../functions/functions.dart';
import '../models/base/language_modle.dart';
import '../providers/setting_provider.dart';
import '../repo_injection.dart';
import '../utils/sized_utils.dart';
import '../utils/text.dart';

class AppLanguageWidget extends StatefulWidget {
  @override
  State<AppLanguageWidget> createState() => _AppLanguageWidgetState();
}

class _AppLanguageWidgetState extends State<AppLanguageWidget> {
  var settingProvider = sl.get<SettingProvider>();
  @override
  void initState() {
    super.initState();
    settingProvider.selectedLanguage = settingProvider.currentLanguage;
  }

  @override
  void dispose() {
    settingProvider.selectedLanguage = null;
    super.dispose();
  }

  setLanguage(Language language) {
    settingProvider.selectedLanguage = language;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getLang.changeLanguage),
            height10(),
            GridView.builder(
                shrinkWrap: true,
                itemCount: provider.languages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, i) {
                  Language language = provider.languages[i];
                  Color color = provider.selectedLanguage == language
                      ? Colors.green
                      : Colors.grey;
                  return GestureDetector(
                    onTap: () => setLanguage(language),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: provider.selectedLanguage == language
                              ? Border.all(color: color)
                              : null,
                          color: color.withOpacity(0.1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              capText(language.name, context,
                                  style: TextStyle(
                                      color:
                                      provider.selectedLanguage == language
                                          ? color
                                          : null)),
                              width5(),
                              if (provider.selectedLanguage == language)
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: color),
                                  child: const Center(
                                      child: Icon(Icons.done,
                                          color: Colors.white, size: 10)),
                                )
                            ],
                          ),
                          Center(
                              child: Text(
                                language.orgName,
                                style: TextStyle(
                                    color: provider.selectedLanguage == language
                                        ? color
                                        : null,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                  );
                }),
            height10(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    // style: buttonStyle(bgColor: Colors.green),
                    onPressed: () => provider
                        .setLocale(provider.selectedLanguage!)
                        .then((value) => context.pop()),
                    child: Text(getLang.apply),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
