// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/controller/profileController.dart';
import 'package:smartays/view/widget/CustomAppBar.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
          title: "Profile".tr,
          backgroundColor: Color.fromRGBO(143, 148, 251, 1)),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              // TextFormField(
              //   decoration: InputDecoration(
              //       label: Text("email".tr),
              //       hintText: "example@exmple.com",
              //       border: OutlineInputBorder()),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // TextFormField(
              //   decoration: InputDecoration(
              //       label: Text("password".tr),
              //       hintText: "your password".tr,
              //       border: OutlineInputBorder()),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   decoration: InputDecoration(
              //       label: Text("phone number".tr),
              //       hintText: "05xxxxxxxx",
              //       border: OutlineInputBorder()),
              // ),
            ],
          );
        },
      ),
    );
  }
}
