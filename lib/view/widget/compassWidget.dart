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
                child: Obx(() => Text(
                      controller.distance.value.toString() + "m".tr,
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ))),
            Expanded(
              flex: 9,
              child: Padding(
                padding: EdgeInsets.all(80),
                child: Obx(() {
                  return RotationTransition(
                    turns: AlwaysStoppedAnimation(controller.degree.value),
                    child: Image.asset("assets/images/arrow.png"),
                  );
                }),
              ),
            )
          ]),
        )));
