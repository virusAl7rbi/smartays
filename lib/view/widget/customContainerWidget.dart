// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

CContainer({required Widget child}) => SizedBox.expand(
      child: Container(
        child: child,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/back.png",
                ),
                fit: BoxFit.cover)),
      ),
    );
