import 'package:flutter/material.dart';

import 'language_data_model.dart';

List<LanguageDataModel> languagesModels = [
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

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) =>
      Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get appName;
  String get settings;
  String get search;
  String get all;
  String get profile;
  String get notificaitons;
  String get about;
  String get signIn;
  String get signUp;
  String get signOut;
  String get register;
  String get findYourHappiness;
  String get firstName;
  String get lastName;
  String get enterEmailAddress;
  String get contactNumber;
  String get update;
  String get cartItemsNotAdded;
  String get favoriteItemsNotAdded;
  String get general;
  String get currency;
  String get deliveryAddress;
  String get language;
  String get order;
  String get promotion;
  String get newArrival;
  String get buy;
  String get addToCart;
  String get swipeUpToDetails;
  String get subTotal;
  String get totalNumbersItems;
  String get totalPrice;
  String get checkout;
  String get email;
  String get password;
  String get forgetPassword;
  String get dontHaveAnAccount;
  String get pleaseAddEmailAndPass;
  String get pleaseAddEmailToRecoverPassword;
  String get pleaseEseYourEmailToRegister;
  String get fullName;
  String get confirmPass;
  String get back;
  String get loading;
  String get selectedProducts;
  String get deliveryDetails;
  String get orderSummery;
  String get forgetPass;
  String get totalNumberOfItems;
  String get deliveryCharge;
  String get total;
  String get confirm;
  String get orderPlaceSuccess;
  String get orderDetails;
  String get swap;
  String get checkYourInboxPlease;
  String get date;
  String get time;
  String get orderStatus;
  String get pending;
  String get orders;
  String get description;
  String get price;
  String get name;
  String get mostOrderedProducts;
}
