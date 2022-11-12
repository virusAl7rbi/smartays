// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:smartays/view/homePage.dart';
import 'package:smartays/service/apiService.dart';
import 'package:smartays/view/loginPage.dart';

class LandingPageController extends GetxController {
  FlutterSecureStorage localStorage = FlutterSecureStorage();
  ApiClient api = ApiClient();

  checkUserState(context) async {
    String? token;
    await localStorage.read(key: "token").then((value) => token = value);
    if (token != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    }
    await localStorage.read(key: "language").then((language) {
      if (language.runtimeType == null) {
        Map langs = {"en": Locale("en", "US"), "ar": Locale('ar', 'SA')};
        Get.updateLocale(langs['language']);
      }
    });
  }

  LandingPageController(context) {
    checkUserState(context);
  }
}
