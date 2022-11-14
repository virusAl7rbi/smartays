// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import 'package:smartays/service/apiService.dart';
import 'package:smartays/service/localAuth.dart';

class HomeController extends GetxController {
  // api client
  ApiClient api = ApiClient();
// local storage
  FlutterSecureStorage localStorage = FlutterSecureStorage();
  TextEditingController permission = TextEditingController();
  navigate(context, page) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) => page)));
  }

  checkIn(context) async {
    await LocalAuth.authenticate();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    api
        .checkIn(
            lat: position.latitude.toString(),
            lon: position.longitude.toString(),
            deviceId: "234")
        .then((response) => {
              printInfo(info: response),
              if (response == "checked")
                {
                  Get.dialog(AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok".tr))
                            ],
                            content: Text("checked In".tr),
                          ))
                }
              else if (response == "out of ponders")
                {
                  Get.dialog( AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok".tr))
                            ],
                            content: Text("Need to be in the building".tr),
                          ))
                }
              else
                {
                  Get.dialog( AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok".tr))
                            ],
                            content: Text("already checked In".tr),
                          ))
                }
            });
  }

  checkOut(context) async {
    await LocalAuth.authenticate();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    api
        .checkOut(
            lat: position.latitude.toString(),
            lon: position.longitude.toString(),
            deviceId: "234")
        .then((response) => {
              // response = response['message'],
              printInfo(info: "${response.runtimeType}"),
              if (response == "check in First")
                {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok".tr))
                            ],
                            content: Text("First check in".tr),
                          ))
                }
              else if (response == " You are not in the specified location ")
                {
                  Get.dialog( AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok".tr))
                            ],
                            content: Text(
                                " You are not in the specified location ".tr),
                          ))
                }
              else if (response == " It has already check out ")
                {
                  Get.dialog( AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok".tr))
                            ],
                            content: Text(" It has already check out ".tr),
                          ))
                }
              else
                {
                  Get.dialog( AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok".tr))
                            ],
                            content: Text("checked Out".tr),
                          ))
                }
            });
  }

  leave(context) async {
    await LocalAuth.authenticate();
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("leave reason".tr),
              content: Row(children: [
                SizedBox(
                  width: MediaQuery.of(ctx).size.width * 0.55,
                  child: TextField(
                    controller: permission,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      api.userAskPermission(permission.text);
                      Navigator.pop(ctx);
                    },
                    icon: Icon(Icons.send_rounded))
              ]),
            ));
  }

  checkGPS() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      } else {
        print("GPS Location service is granted");
      }
    } else {
      print("GPS Location permission granted.");
    }
  }

  HomeController() {
    checkGPS();
  }
}
