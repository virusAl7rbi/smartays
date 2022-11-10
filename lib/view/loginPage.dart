import 'package:flutter/material.dart';
import 'package:smartays/view/widget/CustomAppBar.dart';
import 'package:smartays/view/widget/customContainerWidget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CContainer(
          child: Column(
        children: [
          CAppBar("name")
        ],
      )),
    );
  }
}
