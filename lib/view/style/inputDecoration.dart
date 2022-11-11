// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CInputDecoration({String? hint, String? label, String? errorText}) =>
    InputDecoration(
        border: OutlineInputBorder(),
        hintText: hint!.tr,
        label: Text(label!.tr),
        fillColor: Colors.white,
        errorText: errorText?.tr,
        
        );
