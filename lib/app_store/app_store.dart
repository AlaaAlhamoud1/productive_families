import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productive_families/core/local/app_localization.dart';
import 'package:productive_families/core/local/language_data_model.dart';
import 'package:productive_families/core/local/languages/language_ar.dart';
import 'package:productive_families/core/local/languages/language_en.dart';
import 'package:productive_families/core/utils/functions.dart';
import 'package:productive_families/core/values/constant.dart';
import 'package:productive_families/data/local_data/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

late SharedPreferences sharedPreferences;

LanguageDataModel? selectedLanguageDataModel;

List<LanguageDataModel> localeLanguageList = [
  LanguageDataModel(
      id: 1,
      name: 'English',
      languageCode: 'en',
      fullLanguageCode: 'en-US',
      flag: 'assets/images/ic_us.png'),
  LanguageDataModel(
      id: 2,
      name: 'Arabic',
      languageCode: 'ar',
      fullLanguageCode: 'ar-AR',
      flag: 'assets/images/ic_ar.png'),
];

Color defaultToastBackgroundColor = Colors.grey.shade200;
Color defaultToastTextColor = Colors.black;
ToastGravity defaultToastGravityGlobal = ToastGravity.CENTER;

PlatformDispatcher platformDispatcher =
    WidgetsBinding.instance.platformDispatcher;

class AppStore {
  bool isDarkMode = false;

  String selectedLanguageCode = platformDispatcher.locale.languageCode;

  final double defaultWidth = 430;
  final double defaultHeight = 925;

  double width = 0;
  double height = 0;

  initial() async {
    sharedPreferences = await SharedPreferences.getInstance();

    Size screenSize =
        MediaQueryData.fromView(platformDispatcher.implicitView!).size;
    Orientation orientation =
        MediaQueryData.fromView(platformDispatcher.implicitView!).orientation;

    if (orientation == Orientation.portrait) {
      width = screenSize.width;
      height = screenSize.height;
    } else {
      width = screenSize.height;
      height = screenSize.width;
    }
    Functions.printDone("=> Done adding device size .");

    selectedLanguageCode = getStringAsync(SELECTED_LANGUAGE_CODE,
        defaultValue: platformDispatcher.locale.languageCode);
    selectedLanguageCode == "en"
        ? language = LanguageEn()
        : language = LanguageAr();

    Functions.printDone("=> Done adding device language .");

    int themeIndex = getIntAsync(THEME_MODE_INDEX, defaultValue: 0);
    isDarkMode = isDarkMode = themeIndex == 1
        ? false
        : themeIndex == 2
            ? true
            : platformDispatcher.platformBrightness.name == "dark";
    Functions.printDone("=> Done adding device theme .");
  }

  Future<void> setDarkMode(int themeIndex) async {
    isDarkMode = themeIndex == 1
        ? false
        : themeIndex == 2
            ? true
            : platformDispatcher.platformBrightness.name == "dark";
  }

  Future<void> setLanguage(String val) async {
    selectedLanguageCode = val;
    language =
        await const AppLocalizations().load(Locale(selectedLanguageCode));
  }
}
