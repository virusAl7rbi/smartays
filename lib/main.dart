// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:smartays/view/landingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartAyes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: LandingPage()),
    );
  }
}
