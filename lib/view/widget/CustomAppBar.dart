// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

updateLanguage(locale) {
  print(locale);
  Get.back();
  Get.updateLocale(locale['locale']);
}

final List locale = [
  {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
  {'name': 'ARABIC', 'locale': Locale('ar', 'SA')},
];
Map currentlanguage = locale[0];

CAppBar(String title) => AppBar(
      centerTitle: true,
      title: Text(title.tr),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        DropdownButton(
            icon: Icon(Icons.language),
            
            items: locale.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e['name']),
              );
            }).toList(),
            onChanged: (value) {
              // currentlanguage = value;
              updateLanguage(value);
            }),
      ],
    );
