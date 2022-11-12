// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables,  prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/l10n/localizationString.dart';
import 'package:smartays/view/homePage.dart';
import 'package:smartays/view/landingPage.dart';
import 'package:smartays/view/profilePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalizationString(),
      locale: Locale("en", "US"),
      title: 'SmartAyes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: ProfilePage()),
    );
  }
}
