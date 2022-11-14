// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/controller/landingController.dart';
import 'package:smartays/view/widget/loadingWidget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LandingPageController());
    Future.delayed(Duration.zero, () {
      Get.dialog(Loading()); // wait until page load to show the dialog
    });
    return Scaffold(
      body: Image.asset(
        "assets/images/back.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
