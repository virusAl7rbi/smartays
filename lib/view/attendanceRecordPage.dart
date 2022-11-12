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
          controller.getAttendanceRecord();
          return ListView.separated(
            padding: EdgeInsets.all(20),
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              return Container(
                height: 120,
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: controller.cardDesign,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Date\n${controller.recordItems[index]['Date']}".tr,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Check Out\n${controller.recordItems[index]['checkOut']}"
                            .tr,
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
                        "Day\n${controller.recordItems[index]['Day']}".tr,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Check In\n${controller.recordItems[index]['checkIn']}"
                            .tr,
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
