// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

updateLanguage(locale) {
  print(locale);
  Get.back();
  Get.updateLocale(locale['locale']);
}

final List locale = [
  {'name': '🇺🇸', 'locale': Locale('en', 'US')},
  {'name': '🇸🇦', 'locale': Locale('ar', 'SA')},
];
Map currentlanguage = locale[0];

CAppBar(String title) => AppBar(
      centerTitle: true,
      title: Text(title.tr),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        DropdownButton(
            icon: Icon(
              Icons.language,
              color: Colors.black,
              size: 40,
            ),
            alignment: AlignmentDirectional.center,
            items: locale.map((e) {
              return DropdownMenuItem(
                alignment: AlignmentDirectional.center,

                value: e,
                child: Text(e['name'], style: TextStyle(fontSize: 30),),
              );
            }).toList(),
            onChanged: (value) {
              // currentlanguage = value;
              updateLanguage(value);
            }),
      ],
    );
