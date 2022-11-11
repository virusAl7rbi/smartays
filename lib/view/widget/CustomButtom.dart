// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget CButton(onPressed, String text) => SizedBox(
      width: double.maxFinite,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,

          backgroundColor: Color.fromRGBO(143, 148, 251, 0.75),

          // maximumSize: Size(30, 40)
        ),
        child: Text(
          text.tr,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
