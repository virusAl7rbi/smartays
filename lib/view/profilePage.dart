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
              TextFormField(
                initialValue: controller.email,
                decoration: InputDecoration(
                    enabled: false,
                    label: Text("email".tr),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: controller.name,
                enabled: false,
                decoration: InputDecoration(
                    label: Text("name".tr), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: controller.phone,
                decoration: InputDecoration(
                    enabled: false,
                    label: Text("phone number".tr),
                    hintText: "05xxxxxxxx",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton.icon(
                onPressed: () => controller.logout,
                label: Text(
                  "Log out".tr,
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(Icons.logout_rounded),
              )
            ],
          );
        },
      ),
    );
  }
}
