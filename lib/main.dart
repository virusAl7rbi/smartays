// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables,  prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/l10n/localizationString.dart';
import 'package:smartays/view/landingPage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async{
await SentryFlutter.init(
(options) => options.dns= "https://5bad748f36bf4f489804a2a3d1efa4f6@o4504258544336896.ingest.sentry.io/4504258546892800".
  appRunner: ()=>runApp(MyApp())
);
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
      home: SafeArea(child: LandingPage()),
    );
  }
}
