// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

Loading(context) => showDialog(
      context: context,
      builder: (context) => Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
              // backgroundColor: Colors.transparent,
              color: Color.fromRGBO(143, 148, 251, 0.8)),
        ),
      ),
    );
