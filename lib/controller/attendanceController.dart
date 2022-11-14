// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartays/service/apiService.dart';
import 'package:smartays/view/widget/loadingWidget.dart';

class AttendanceController extends GetxController {
  BoxDecoration cardDesign = BoxDecoration(
    color: Color.fromRGBO(36, 132, 201, 0.75),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );

  ApiClient api = ApiClient();
  int recordLength = 0;
  List recordItems = [];
  String to12(String dateTime) {
    String timeFormat = "hh:mm:ss";
    var parsed = DateFormat(timeFormat).parse(dateTime);
    String formated = DateFormat("hh:mm:ss a").format(parsed);
    return formated;
  }

  loadingDialog() {
    Get.dialog(
      Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
              // backgroundColor: Colors.transparent,
              color: Color.fromRGBO(143, 148, 251, 0.8)),
        ),
      ),
    );
    Get.back();
  }

  getAttendanceRecord() async {
    Future.delayed(Duration.zero, () {
      Get.dialog(Loading());
    });
    await api.attendanceRecord().then((response) => {
          recordLength = response.length,
          recordItems = response
              .map((record) => {
                    "Day": record['day'],
                    "checkIn": to12(record['morning']),
                    "checkOut": record['evening'] == 0
                        ? record['evening']
                        : to12(record['evening']),
                    "Date": record['date'],
                  })
              .toList()
        });
    Get.back();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAttendanceRecord();
  }
}
