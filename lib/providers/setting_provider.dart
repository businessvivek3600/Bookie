import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_global_tools/constants/sp_constants.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/sp_utils.dart';

import '../models/base/language_modle.dart';

class SettingProvider extends ChangeNotifier {
  SettingProvider({required this.spUtils}) {
    initCurrentLanguage();
  }
  final Sp spUtils;
  static const String tag = 'SettingProvider';

  // theme control
  ThemeMode themeMode = ThemeMode.light;
  setThemeMode(BuildContext context) {
    themeMode = useLightMode(context) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  useLightMode(BuildContext context) {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  //language setting

  List<Language> languages = [
    Language(
        name: 'English',
        orgName: 'English',
        code: 'en',
        active: 1,
        dir: 1,
        countryCode: 'US'),
    Language(
        name: 'Hindi',
        orgName: 'हिंदी',
        code: 'ar',
        active: 1,
        dir: 1,
        countryCode: 'EG'),
    Language(
        name: 'Arabic',
        orgName: 'मराठी',
        code: 'ar',
        active: 1,
        dir: 0,
        countryCode: 'EG'),
  ];

  late Language currentLanguage;
  Language? selectedLanguage;
  late Locale currentLocale;

  Future<void> initCurrentLanguage() async {
    String localeString =
        spUtils.getString(SPConst.locale) ?? Intl.getCurrentLocale();
    currentLocale =
        Locale(localeString.split('_')[0], localeString.split('_')[1]);
    currentLanguage = languages
        .firstWhere((element) => element.code == currentLocale.languageCode);
    notifyListeners();
  }

  Future<void> setLocale(Language language) async {
    String localeString = '${language.code}_${language.countryCode}';
    infoLog('localeString -> $localeString', tag);
    await spUtils.setString(SPConst.locale, localeString);
    await initCurrentLanguage();
  }
}
