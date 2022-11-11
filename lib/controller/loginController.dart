// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/service/apiService.dart';
import 'package:email_validator/email_validator.dart';
import 'package:smartays/view/homePage.dart';

class LoginController extends GetxController {
  // text filed controllers
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  // error text
  String? emailError;
  String? passwordError;
  // api client
  ApiClient api = ApiClient();

  formValidator() async {
    // check for empty input
    if (emailCont.text.isEmpty) {
      emailError = "please enter your email";
      return false;
    }
    if (passwordCont.text.isEmpty) {
      emailError = "please enter your password";
      return false;
    }
    // validate email
    if (EmailValidator.validate(emailCont.text) == false) {
      emailError = "please write valid email";
      return false;
    }
  }

  login(context) async {
    await formValidator().then((isValid) {
      if (isValid == false) {
        update();
      }
    });
    if (emailError == null && passwordError == null) {
      api.login(emailCont.text, passwordCont.text).then((response) {
        if (response!.isNotEmpty) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        } else {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("ok"))
                    ],
                  )));
        }
      });
    }
  }
}
