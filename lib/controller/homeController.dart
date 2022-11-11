// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import 'package:smartays/service/apiService.dart';

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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    api
        .checkIn(
            lat: position.latitude.toString(),
            lon: position.longitude.toString(),
            deviceId: "234")
        .then((response) => {
              if (response == "checked")
                {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok"))
                            ],
                            content: Text("checked In"),
                          ))
                }
              else if (response == "out of ponders")
                {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok"))
                            ],
                            content: Text("Need to be in the building"),
                          ))
                }
              else
                {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ok"))
                            ],
                            content: Text("already checked In"),
                          ))
                }
            });
  }

  checkOut(context) async {
    api.checkOut().then((response) => {
          if (response == "check in First")
            {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Ok"))
                        ],
                        content: Text("First check in"),
                      ))
            }
          else
            {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Ok"))
                        ],
                        content: Text("checked Out"),
                      ))
            }
        });
  }

  leave(context) async {
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
                    onPressed: () =>
                        api.userAskPermission(permission.text),
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
