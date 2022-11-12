// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/controller/landingController.dart';
import 'package:smartays/view/widget/loadingWidget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LandingPageController(context));
    Future.delayed(Duration.zero, () {
      Loading(context); // wait until page load to show the dialog
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/back.png",
                ),
                fit: BoxFit.cover)),
      ),
    );
  }
}
