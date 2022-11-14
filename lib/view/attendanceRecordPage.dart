// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/controller/attendanceController.dart';
import 'package:smartays/view/widget/CustomAppBar.dart';
import 'package:smartays/view/widget/loadingWidget.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
          title: "Attendance History",
          backgroundColor: Color.fromRGBO(143, 148, 251, 1)),
      body: GetBuilder<AttendanceController>(
        init: AttendanceController(),
        builder: (controller) {
          return ListView.separated(
            padding: EdgeInsets.all(20),
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              return Container(
                height: 135,
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: controller.cardDesign,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Date".tr +
                            "\n${controller.recordItems[index]['Date']}",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Check In".tr +
                            "\n${controller.recordItems[index]['checkIn']}",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                    thickness: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Day".tr +
                            "\n" +
                            controller.recordItems[index]['Day'].toString().tr,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Check Out".tr +
                            "\n${controller.recordItems[index]['checkOut']}",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ]),
              );
            },
            itemCount: controller.recordLength,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 20,
            ),
          );
        },
      ),
    );
  }
}
