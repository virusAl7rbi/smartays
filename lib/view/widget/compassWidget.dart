import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/controller/compassController.dart';

Widget compass() => GetBuilder<CompassController>(
    init: CompassController(),
    builder: ((controller) => Container(
          width: double.infinity,
          height: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Obx(() => Text(
                        controller.distance.value.toString() + "m".tr,
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      )),
                )),
            Flexible(
              flex: 9,
              child: controller.map,
            )
          ]),
        )));
