// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/controller/homeController.dart';
import 'package:smartays/view/attendanceRecordPage.dart';
import 'package:smartays/view/profilePage.dart';
import 'package:smartays/view/widget/CustomAppBar.dart';
import 'package:smartays/view/widget/CustomButton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: [
        CAppBar(
          title: "Smart Fingerprint".tr,
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        ),
        GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(143, 148, 251, 0.34),
                          // width: MediaQuery.of(context).size.width * 0.9,
                        ),
                      ),
                      child: controller.compassWidget(),
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                    GridView.count(
                      childAspectRatio: 6 / 1.8,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        CButton(() => controller.checkIn(context), "check in"),
                        CButton(
                            () => controller.checkOut(context), "check out"),
                        CButton(() => controller.leave(context), "Leave"),
                        CButton(
                            () => controller.navigate(context, ProfilePage()),
                            "My Profile"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CButton(
                        () => controller.navigate(context, AttendancePage()),
                        "Attendance History")
                  ],
                ),
              );
            })
      ]),
    );
  }
}
