// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartays/controller/loginController.dart';
import 'package:smartays/view/style/inputDecoration.dart';
import 'package:smartays/view/widget/CustomAppBar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                CAppBar(),
                GetBuilder<LoginController>(
                    init: LoginController(),
                    builder: (controller) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: controller.emailCont,
                                decoration: CInputDecoration(
                                    errorText: controller.emailError,
                                    hint: "example@example.com",
                                    label: "email".tr),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: controller.passwordCont,
                                obscureText:
                                    true, // to make`t the star show when write password
                                decoration: CInputDecoration(
                                    errorText: controller.passwordError,
                                    hint: "your password".tr,
                                    label: "password".tr),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextButton.icon(
                                  onPressed: () => controller.login(context),
                                  icon: Icon(Icons.login_outlined),
                                  label: Text("Login".tr))
                            ],
                          ),
                        ),
                      );
                    })
              ],
            )),
      ],
    );
  }
}
