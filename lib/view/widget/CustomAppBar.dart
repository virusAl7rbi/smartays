// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

updateLanguage(locale) async {
  FlutterSecureStorage localStorage = FlutterSecureStorage();
  Get.updateLocale(locale['locale']);
  localStorage.write(key: "language", value: locale['locale'].languageCode);
}

final List locale = [
  {'name': '🇺🇸', 'locale': Locale('en', 'US')},
  {'name': '🇸🇦', 'locale': Locale('ar', 'SA')},
];
Map currentlanguage = locale[0];

CAppBar({
  String? title = "",
  Color backgroundColor = Colors.transparent,
}) =>
    AppBar(
      centerTitle: true,
      toolbarHeight: 80,
      title: Text(title!.tr),
      backgroundColor: backgroundColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(80, 56.0),
        ),
      ),
      actions: [
        DropdownButton(
            underline: Container(
              height: 0,
            ),
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
                child: Text(
                  e['name'],
                  style: TextStyle(fontSize: 30),
                ),
              );
            }).toList(),
            onChanged: (value) {
              // currentlanguage = value;
              updateLanguage(value);
            }),
      ],
    );
