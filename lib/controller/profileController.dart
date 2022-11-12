// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:smartays/service/apiService.dart';
import 'package:smartays/view/loginPage.dart';

class ProfileController extends GetxController {
// api
  ApiClient api = ApiClient();
  //localstorage
  FlutterSecureStorage localStorage = FlutterSecureStorage();
  String? name;
  String? email;
  String? phone;
  getUserInfo() async {
    api.getProfile().then((response) {
      name = response['name'];
      email = response['email'];
      phone = response['phone'];
    });
  }

  logout(context) async {
    await localStorage.delete(key: "token");
    api.logout();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => LoginPage())),
        (route) => false);
  }
}
