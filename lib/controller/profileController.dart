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
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  getUserInfo() async {
    api.getProfile().then((response) {
      name.text = response['name'];
      email.text = response['email'];
      phone.text = response['phone'];
      update();
    });
  }

  logout(context) async {
    api.logout();
    await localStorage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => LoginPage())),
        (route) => false);
  }

  ProfileController() {
    getUserInfo();
  }
}
