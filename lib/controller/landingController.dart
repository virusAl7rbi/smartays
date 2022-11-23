// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:io';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:smartays/view/homePage.dart';
import 'package:smartays/service/apiService.dart';
import 'package:smartays/view/loginPage.dart';

class LandingPageController extends GetxController {
  FlutterSecureStorage localStorage = FlutterSecureStorage();
  ApiClient api = ApiClient();

  toHomePage() => Get.off(() => HomePage());

  toLoginPage() => Get.off(() => LoginPage());

  checkUserState() async {
    String? token;
    await localStorage.read(key: "token").then((value) => token = value);
    if (token != null) {
      api.getTimework().then((response) {
        if (response['status'] == "Token is Expired") {
          toLoginPage();
        } else {
          toHomePage();
        }
      });
    } else {
      toLoginPage();
    }

    await localStorage.read(key: "language").then((language) {
      if (language.runtimeType == null) {
        Map langs = {"en": Locale("en", "US"), "ar": Locale('ar', 'SA')};
        Get.updateLocale(langs['language']);
      }
    });
  }

  Future<bool> isVPNused() async {
    if (await CheckVpnConnection.isVpnActive()) {
      Get.defaultDialog(
          onCancel: () => SystemNavigator.pop(),
          barrierDismissible: false,
          content: Text(
              "VPN is Activated, please turn it off before using the app".tr),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Ok".tr),
            )
          ]);
      return true;
    }
    return false;
  }

  Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      Get.defaultDialog(
          actions: [
            TextButton(
                onPressed: () => SystemNavigator.pop(), child: Text("Ok".tr))
          ],
          content: Text("Check your internet connection".tr),
          barrierDismissible: false);
      return false;
    }
  }

  Future internetChecking() async {
    bool? vpnUsed = await isVPNused();
    bool? internetConnection = await isInternetConnected();
    print("is vpn used: $vpnUsed");
    print("network connection status: $internetConnection");
    if (vpnUsed == false && internetConnection) {
      checkUserState();
    }
  }

  @override
  void onInit() {
    internetChecking();
    super.onInit();
  }
}
